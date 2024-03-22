# ARPPoisoner.sh
ARP Poisoning bashscript helper script PoC with wireshark support

## Usage

> [!NOTE]
> Requires the tools qterminal, arpspoof, wireshark / tcpdump (maybe here is some chnaging of the source required)
> These tools are includes in kali suite!

````bash
git clone https://github.com/suuhm/ARPPoisoner.sh && cd arppoisoner.sh && chmod +x arppoisoner.sh

.\arppoisoner.sh VICTIM-IP [GATEWAY/HOST]

````

## Features

- Detects automatic Network devices and your Gateway if no host is set
- Starts Wireshark with "maybe" useful display filters
- Clears automatic ARP cache and arpsoof on wireshark closing

## Todos

- Adding more stable code
- Adding some mitmproxy support
- Adding SSL/TLS (Termination) sniffing
- Cleaner interface
