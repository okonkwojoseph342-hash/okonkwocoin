# Okonkwocoin (OKC) 🪙

A SIP-010 compliant fungible token smart contract built on the Stacks blockchain, named after Chinua Achebe's iconic character Okonkwo from "Things Fall Apart". This token represents strength, determination, and resilience in the decentralized finance ecosystem.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Token Specifications](#token-specifications)
- [Getting Started](#getting-started)
- [Installation](#installation)
- [Usage](#usage)
- [Contract Functions](#contract-functions)
- [Testing](#testing)
- [Deployment](#deployment)
- [Security](#security)
- [Contributing](#contributing)
- [License](#license)

## 🌟 Overview

Okonkwocoin is a fungible token that follows the SIP-010 standard for Stacks blockchain. It provides a complete token implementation with additional features like minting controls, pausing mechanisms, and administrative functions while maintaining compatibility with the broader Stacks ecosystem.

## ✨ Features

- **SIP-010 Compliance**: Fully implements the SIP-010 fungible token standard
- **Minting Control**: Authorized minters can create new tokens
- **Burn Functionality**: Token holders can burn their tokens
- **Pause Mechanism**: Contract owner can pause operations for emergency situations
- **Administrative Controls**: Owner-only functions for contract management
- **Event Logging**: All major actions are logged for transparency
- **Security**: Built-in access controls and input validation

## 🔧 Token Specifications

| Property | Value |
|----------|-------|
| **Name** | Okonkwocoin |
| **Symbol** | OKC |
| **Decimals** | 6 |
| **Total Supply** | 100,000,000 OKC (100 million tokens) |
| **Precision** | 1,000,000 (6 decimal places) |

## 🚀 Getting Started

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) installed
- [Node.js](https://nodejs.org/) (for testing)
- Basic knowledge of Clarity smart contracts

### Installation

1. **Clone the repository**:
   ```bash
   git clone <your-repo-url>
   cd okonkwocoin-contract
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Verify setup**:
   ```bash
   clarinet check
   ```

## 💻 Usage

### Basic Operations

#### Check Token Information
```bash
# Get token name
clarinet console --execute "(contract-call? .okonkwocoin get-name)"

# Get token symbol
clarinet console --execute "(contract-call? .okonkwocoin get-symbol)"

# Get total supply
clarinet console --execute "(contract-call? .okonkwocoin get-total-supply)"
```

#### Transfer Tokens
```bash
# Transfer 1000 OKC tokens (1000000000 with 6 decimals)
clarinet console --execute "(contract-call? .okonkwocoin transfer u1000000000 tx-sender 'SP2J6ZY48GV1EZ5V2V5RB9MP66SW86PYKKNRV9EJ7 none)"
```

#### Check Balance
```bash
# Check balance of an address
clarinet console --execute "(contract-call? .okonkwocoin get-balance 'SP2J6ZY48GV1EZ5V2V5RB9MP66SW86PYKKNRV9EJ7)"
```

## 📚 Contract Functions

### SIP-010 Standard Functions

| Function | Type | Description |
|----------|------|-------------|
| `get-name()` | Read-only | Returns token name |
| `get-symbol()` | Read-only | Returns token symbol |
| `get-decimals()` | Read-only | Returns decimal places |
| `get-balance(who)` | Read-only | Returns balance of principal |
| `get-total-supply()` | Read-only | Returns total token supply |
| `get-token-uri()` | Read-only | Returns optional token URI |
| `transfer(amount, from, to, memo)` | Public | Transfers tokens between accounts |

### Extended Functions

#### Minting & Burning
- `mint(amount, to)` - Mint new tokens (authorized minters only)
- `burn(amount, from)` - Burn tokens from account

#### Administrative Functions
- `set-token-uri(new-uri)` - Set token metadata URI (owner only)
- `set-contract-paused(paused)` - Pause/unpause contract (owner only)
- `add-minter(minter)` - Add authorized minter (owner only)
- `remove-minter(minter)` - Remove authorized minter (owner only)

#### Query Functions
- `is-authorized-minter(who)` - Check if address can mint
- `is-contract-paused()` - Check if contract is paused
- `get-contract-owner()` - Get contract owner address

## 🧪 Testing

Run the test suite:

```bash
# Install testing dependencies
npm install

# Run all tests
npm test

# Run specific test file
npm test -- okonkwocoin.test.ts
```

### Test Coverage

The test suite covers:
- Token transfers and balance checks
- Minting and burning functionality
- Administrative controls
- Error conditions and edge cases
- SIP-010 compliance verification

## 🚀 Deployment

### Local Development
```bash
# Start local development environment
clarinet integrate

# Deploy to local testnet
clarinet deploy --testnet
```

### Mainnet Deployment
```bash
# Deploy to Stacks mainnet (requires STX for fees)
clarinet deploy --mainnet
```

### Deployment Checklist
- [ ] All tests passing
- [ ] Contract syntax validated
- [ ] Token parameters configured
- [ ] Initial supply allocated
- [ ] Owner permissions verified

## 🔒 Security

### Security Features

1. **Access Control**: Owner-only functions protected by sender verification
2. **Input Validation**: All amounts and addresses validated
3. **Overflow Protection**: Uses Clarity's built-in safe arithmetic
4. **Pause Mechanism**: Emergency stop functionality
5. **Minting Control**: Restricted minting to authorized accounts

### Security Considerations

- Contract owner has significant privileges - use multisig for production
- Minting permissions should be carefully managed
- Consider timelock mechanisms for critical functions
- Regular security audits recommended for mainnet deployment

### Error Codes

| Code | Constant | Description |
|------|----------|-------------|
| 100 | `ERR-OWNER-ONLY` | Function restricted to contract owner |
| 101 | `ERR-NOT-TOKEN-OWNER` | Caller doesn't own the tokens |
| 102 | `ERR-INSUFFICIENT-BALANCE` | Not enough tokens for operation |
| 103 | `ERR-INVALID-AMOUNT` | Amount must be greater than zero |
| 104 | `ERR-UNAUTHORIZED` | Operation not permitted |

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow Clarity best practices
- Add tests for new functionality
- Update documentation as needed
- Ensure all tests pass before submitting

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Named after Okonkwo from Chinua Achebe's "Things Fall Apart"
- Built on the [Stacks](https://stacks.co) blockchain
- Developed with [Clarinet](https://github.com/hirosystems/clarinet)
- Follows [SIP-010](https://github.com/stacksgov/sips/blob/main/sips/sip-010/sip-010-fungible-token-standard.md) standard

## 📞 Support

For support and questions:
- Open an issue in this repository
- Join the [Stacks Discord](https://discord.gg/zrvWsQC)
- Check the [Clarity documentation](https://docs.stacks.co/clarity)

---

**Disclaimer**: This smart contract is provided as-is. Please conduct thorough testing and security audits before using in production environments.