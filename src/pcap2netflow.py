#!/usr/bin/env python3
"""
> sudo apt-get install nfdump

Generate nfdump flow records from a PCAP:
> nfpcapd -r input.pcap -l ./flows

Export CSV:
> nfdump -R ./flows -o csv > flows.csv

Export JSON:
> nfdump -R ./flows -o json > flows.json

PCAP -> NetFlow/IPFIX converter using nfpcapd as backend engine.

                        PCAP
                         ↓
                    Generate flows
                         ↓
                Export NetFlow v5-like JSON
                         or
                Export NetFlow v9-like JSON

Usage:
        python pcap2netflow.py \
          -i traffic.pcap \
          -v v5 \
          -o netflow_v5.json

        python pcap2netflow.py \
          -i traffic.pcap \
          -v v9 \
          -o netflow_v9.json
"""

import argparse
import json
import subprocess
import tempfile
import shutil
from pathlib import Path


def pcap_to_netflow_json(pcap_file: str, output_json: str, version: str = "v5"):
    """
    Convert PCAP to NetFlow-like JSON using nfpcapd+nfdump.

    version:
        v5 -> emit NetFlow v5 style fields
        v9 -> emit NetFlow v9/IPFIX style fields
    """

    tmpdir = tempfile.mkdtemp(prefix="nfdump_")
    print(f"--->{tmpdir}")

    try:
        # Generate flow files from PCAP
        subprocess.run(
            [
                "nfpcapd",
                "-r", pcap_file,
                "-l", tmpdir
            ],
            check=True
        )

        subprocess.run(
                [
                    "ls",
                    "-al", tmpdir
                ],
                check=True
        )
        
        # Export as JSON
        result = subprocess.run(
            [
                "nfdump",
                "-R", tmpdir,
                "-o", "json"
            ],
            text=True,
            capture_output=True,
            check=True
        )
        
        print(f"--> {result.stdout}")

        flows = json.loads(result.stdout)

        converted = []

        for flow in flows:

            if version.lower() == "v5":
                converted.append({
                    "srcaddr":      flow.get("src4_addr"),
                    "dstaddr":      flow.get("dst4_addr"),
                    "srcport":      flow.get("src_port"),
                    "dstport":      flow.get("dst_port"),
                    "prot":         flow.get("proto"),
                    "dPkts":        flow.get("in_packets"),
                    "dOctets":      flow.get("in_bytes"),
                    "tcp_flags":    flow.get("tcp_flags"),
                    "first":        flow.get("first"),
                    "last":         flow.get("last")
                })

            elif version.lower() == "v9":
                converted.append({
                    "sourceIPv4Address":        flow.get("src4_addr"),
                    "destinationIPv4Address":   flow.get("dst4_addr"),
                    "sourceTransportPort":      flow.get("src_port"),
                    "destinationTransportPort": flow.get("dst_port"),
                    "protocolIdentifier":       flow.get("proto"),
                    "packetDeltaCount":         flow.get("in_packets"),
                    "octetDeltaCount":          flow.get("in_bytes"),
                    "tcpControlBits":           flow.get("tcp_flags"),
                    "flowStartMilliseconds":    flow.get("first"),
                    "flowEndMilliseconds":      flow.get("last")
                })

            else:
                raise ValueError("version must be v5 or v9")

        with open(output_json, "w") as fp:
            json.dump(
                converted,
                fp,
                indent=2
            )

        print(
            f"Exported {len(converted)} flows "
            f"to {output_json}"
        )

    finally:
        shutil.rmtree(
            tmpdir,
            ignore_errors=True
        )


def main():

    parser = argparse.ArgumentParser()

    parser.add_argument(
        "-i",
        "--input",
        required=True,
        help="Input pcap"
    )

    parser.add_argument(
        "-o",
        "--output",
        required=True,
        help="Output json"
    )

    parser.add_argument(
        "-v",
        "--version",
        choices=["v5", "v9"],
        default="v5"
    )

    args = parser.parse_args()

    pcap_to_netflow_json(
        args.input,
        args.output,
        args.version
    )


if __name__ == "__main__":
    main()