# Hosting Rationale

This document outlines the rationale for selecting our hosting platform. The evaluation is based on technical and
political requirements, since I have no prior experience with any of these providers.

## Requirements

- **Location**: Data center must be hosted in Brazil for low latency.
- **Independence**: Avoid Big Tech ecosystems: AWS, GCP, Azure, etc.
- **Currency**: Preference for Brazilian companies billing in BRL to avoid USD exposition.
- **Compatibility**: Must support the current stable version of [Debian](./vps_distro.md).

Comparison of Providers

- **DigitalOcean**: Considered a global standard with a presence in São Paulo. However, the billing is in USD, and local
  availability can be inconsistent to provision.
- **Hetzner**: Excellent performance and OS support, but as a foreign company, they bill in EUR. Local São Paulo
  availability remains difficult to secure.
- **KingHost**: Disqualified due to legacy support. They only offer Debian 9 and 10 (both EOL), posing a significant
  security risk.
- **Latitude.sh**: High-quality infrastructure and local presence, but the pricing is prohibitive for our current
  budget.

## Selected Provider: Locaweb

**Locaweb** was selected because it meets all primary criteria. While the pricing is slightly higher than some domestic
competitors, it is the only provider that offers local billing, a Brazilian data center, and support for modern Debian
releases.
