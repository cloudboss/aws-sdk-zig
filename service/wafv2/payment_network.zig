const BlockchainChain = @import("blockchain_chain.zig").BlockchainChain;
const Price = @import("price.zig").Price;

/// A blockchain payment network configuration for receiving AI bot monetization
/// payments. Specifies the blockchain chain, your wallet address on that chain,
/// and the price per request.
pub const PaymentNetwork = struct {
    /// The blockchain network for receiving payments. Production networks: `BASE`
    /// (Base mainnet), `SOLANA` (Solana mainnet). Test networks: `BASE_SEPOLIA`
    /// (Base Sepolia testnet), `SOLANA_DEVNET` (Solana Devnet).
    chain: BlockchainChain,

    /// The price configuration for this payment network. Currently supports a
    /// single price entry in USDC.
    prices: []const Price,

    /// Your wallet address on the specified blockchain where payments are sent. For
    /// EVM chains (Base, Base Sepolia), provide a valid Ethereum address (42
    /// characters including 0x prefix). For Solana chains, provide a valid
    /// Base58-encoded public key (32-44 characters).
    ///
    /// For EVM addresses, WAF performs EIP-55 checksum validation for typo
    /// detection when the address uses a mix of lower and upper case letters. You
    /// can bypass this validation by providing the address in all lowercase or all
    /// uppercase.
    wallet_address: []const u8,

    pub const json_field_names = .{
        .chain = "Chain",
        .prices = "Prices",
        .wallet_address = "WalletAddress",
    };
};
