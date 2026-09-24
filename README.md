<div align="center">

```mermaid
flowchart LR

A[Network Traffic] --> B{Flow Technology}

B --> C[NetFlow]
B --> D[sFlow]
B --> E[IPFIX]

%% NetFlow
C --> C1[Developed by Cisco]
C --> C2[Flow-based Monitoring]
C --> C3[L3/L4 Metadata Export]
C --> C4[Traffic Analysis]
C --> C5[Capacity Planning]

%% sFlow
D --> D1[Developed by InMon]
D --> D2[Packet Sampling]
D --> D3[Interface Statistics]
D --> D4[High-Speed Networks]
D --> D5[Low Resource Usage]

%% IPFIX
E --> E1[IETF Standard]
E --> E2[Template-Based Export]
E --> E3[Extensible Fields]
E --> E4[Vendor Neutral]
E --> E5[Advanced Analytics]

%% Collection
C4 --> F[Flow Collector]
D4 --> F
E4 --> F

F --> G[Storage Database]
G --> H[Network Monitoring]
G --> I[Anomaly Detection]
G --> J[Malware Detection]
G --> K[Security Analytics]
G --> L[Traffic Engineering]
```

# **`Flow Toolkit`** | Network Traffic [Flow](https://wikipedia.org/wiki/Traffic_flow_(computer_networking)) Toolkit
</div>

[![YouTube](https://img.shields.io/badge/YouTube-%23FF0000.svg?style=for-the-badge&logo=YouTube&logoColor=white)](https://youtube.com/playlist?list=PL9V4Zu3RroiWqr2YTIFniPf5GDp6WteEV&si=CiOTgkl-RWMihxkb)
[![Reddit](https://img.shields.io/badge/Reddit-FF4500?style=for-the-badge&logo=reddit&logoColor=white)]()

<p align="center">
    <a href="https://github.com/cybersecurity-dev/"><img height="25" src="https://github.com/cybersecurity-dev/cybersecurity-dev/blob/main/assets/github.svg" alt="GitHub"></a>
    &nbsp;
    <a href="https://www.youtube.com/@CyberThreatDefense"><img height="25" src="https://github.com/cybersecurity-dev/cybersecurity-dev/blob/main/assets/youtube.svg" alt="YouTube"></a>
    &nbsp;
    <a href="https://cyberthreatdefence.com/my_awesome_lists"><img height="20" src="https://github.com/cybersecurity-dev/cybersecurity-dev/blob/main/assets/blog.svg" alt="My Awesome Lists"></a>
    <img src="https://github.com/cybersecurity-dev/cybersecurity-dev/blob/main/assets/bar.gif">
</p>


## 📖 Contents
- [Flow Types](#flow-types)
- [NetFlow](#netflow)
- [sFlow](#sflow)
- [IPFIX](#ipfix)
- [Flow Generator and Analyzer](#flow-generator-and-analyzer)
- [My Awesome Lists](#my-awesome-lists)
- [Contributing](#contributing)
- [Contributors](#contributors)


## Flow Types

```text
                TCP/IP MODEL

        ┌─────────────────────────────┐
        │ Application                 │
        │ HTTP HTTPS DNS SMTP SSH     │◄── IPFIX
        ├─────────────────────────────┤
        │ Transport                   │
        │ TCP UDP SCTP                │◄── NetFlow
        │                             │◄── sFlow
        │                             │◄── IPFIX
        ├─────────────────────────────┤
        │ Internet                    │
        │ IPv4 IPv6 ICMP              │◄── NetFlow
        │                             │◄── sFlow
        │                             │◄── IPFIX
        ├─────────────────────────────┤
        │ Network Access              │
        │ Ethernet VLAN ARP Wi-Fi     │◄── sFlow
        │                             │◄── IPFIX
        └─────────────────────────────┘
```

```text
Technology    Application   Transport   Internet   Network Access

NetFlow            ✗            ✓           ✓            ✗

sFlow              ✗            ✓           ✓            ✓

IPFIX              ✓            ✓           ✓            ✓
```

### [NetFlow](https://wikipedia.org/wiki/NetFlow)
> Who talks to whom? (IP + Ports)
```txt
NetFlow
└── Transport + Internet
    (TCP/UDP + IP)
```

### [sFlow](https://wikipedia.org/wiki/SFlow)
> What is happening on the wire? (Sampled packets + Interfaces)
```txt
sFlow
└── Network Access + Internet + Transport
    (Ethernet + IP + TCP/UDP)
```

### [IPFIX](https://wikipedia.org/wiki/IP_Flow_Information_Export)
> Who talks, how, using what application, and what metadata is available?
```txt
IPFIX
└── All TCP/IP Layers
    (Application + Transport + Internet + Network Access)
```

```mermaid
flowchart LR

A[TCP/IP Layers]

A --> APP[Application]
A --> TR[Transport]
A --> INET[Internet]
A --> NET[Network Access]

INET --> NF[NetFlow]
TR --> NF

NET --> SF[sFlow]
INET --> SF
TR --> SF

NET --> IPF[IPFIX]
INET --> IPF
TR --> IPF
APP --> IPF
```

## Flow Generator and Analyzer

| Tool | Primary role | Input | Output | Best use case | Key advantage | Main consideration |
|---|---|---|---|---|---|---|
| **YAF** | Flow meter and exporter | Live interface, PCAP | IPFIX, IPFIX-based files | Reference baseline for packet-to-flow conversion | Bidirectional IPFIX flow generation and integration with SiLK | Output may require additional conversion for ML pipelines |
| **nProbe** | Flow probe, collector and traffic enricher | Live traffic, PCAP, NetFlow, IPFIX, sFlow | NetFlow, IPFIX, JSON | Application-aware monitoring and DPI | Layer 7 application identification through nDPI | Some advanced functionality may require a commercial licence |
| **CICFlowMeter** | Bidirectional statistical flow generator | PCAP, live interface | CSV | ML/DL intrusion and malware-detection datasets | Produces more than 80 directional and statistical features | Feature definitions, timeouts and duplicated columns require validation |


* [YAF (Yet Another Flowmeter)](https://tools.netsa.cert.org/yaf2/index.html)
##

### My Awesome Lists
You can access the my awesome lists [here](https://cyberthreatdefence.com/my_awesome_lists)

### Contributing
[Contributions of any kind welcome, just follow the guidelines](contributing.md)!

### Contributors
[Thanks goes to these contributors](https://github.com/cybersecurity-dev/NetFlow-Toolkit/graphs/contributors)!

[🔼 Back to top](#flow-toolkit--network-traffic-flow-toolkit)
