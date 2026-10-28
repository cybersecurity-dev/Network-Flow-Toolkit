#!/bin/bash
# pcap2ipfix.sh
# Usage: ./pcap2ipfix.sh <input.pcap> [collector_ip] [collector_port]

INPUT_PCAP=$1
COLLECTOR_IP=${2:-"127.0.0.1"}
COLLECTOR_PORT=${3:-"4739"} # Default standard IPFIX port

if [ -z "$INPUT_PCAP" ]; then
    echo "Error: No input PCAP file specified."
    echo "Usage: $0 <input.pcap> [collector_ip] [collector_port]"
    exit 1
fi

if [ ! -f "$INPUT_PCAP" ]; then
    echo "Error: File '$INPUT_PCAP' does not exist."
    exit 1
fi

echo "[*] Processing PCAP: $INPUT_PCAP"
echo "[*] Exporting as IPFIX (v10) to $COLLECTOR_IP:$COLLECTOR_PORT..."

# softflowd uses version 10 (-v 10) for IPFIX export
softflowd -r "$INPUT_PCAP" -v 10 -n "$COLLECTOR_IP:$COLLECTOR_PORT"

echo "[+] IPFIX conversion process finished."

