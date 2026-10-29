#!/bin/bash
# pcap2netflow.sh
# Usage: ./pcap2netflow.sh <input.pcap> [collector_ip] [collector_port] [netflow_version]

INPUT_PCAP=$1
COLLECTOR_IP=${2:-"127.0.0.1"}
COLLECTOR_PORT=${3:-"2055"}
NF_VERSION=${4:-"5"} # Default to NetFlow v5 (can use 9 for IPv6/v9 support)

if [ -z "$INPUT_PCAP" ]; then
    echo "Error: No input PCAP file specified."
    echo "Usage: $0 <input.pcap> [collector_ip] [collector_port] [netflow_version]"
    exit 1
fi

if [ ! -f "$INPUT_PCAP" ]; then
    echo "Error: File '$INPUT_PCAP' does not exist."
    exit 1
fi

echo "[*] Processing PCAP: $INPUT_PCAP"
echo "[*] Exporting as NetFlow v$NF_VERSION to $COLLECTOR_IP:$COLLECTOR_PORT..."

# Run softflowd in read-file mode (-r)
softflowd -r "$INPUT_PCAP" -v "$NF_VERSION" -n "$COLLECTOR_IP:$COLLECTOR_PORT"

echo "[+] NetFlow conversion process finished."