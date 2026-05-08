const std = @import("std");

/// Supported blockchain chain identifiers for balance queries.
/// Each value maps to a specific chain supported by the underlying providers
/// (Privy, Coinbase).
pub const BlockchainChainId = enum {
    /// Base Mainnet (EVM L2)
    base,
    /// Base Sepolia testnet (EVM L2)
    base_sepolia,
    /// Ethereum Mainnet (EVM L1)
    ethereum,
    /// Solana Mainnet
    solana,
    /// Solana Devnet testnet
    solana_devnet,

    pub const json_field_names = .{
        .base = "BASE",
        .base_sepolia = "BASE_SEPOLIA",
        .ethereum = "ETHEREUM",
        .solana = "SOLANA",
        .solana_devnet = "SOLANA_DEVNET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .base => "BASE",
            .base_sepolia => "BASE_SEPOLIA",
            .ethereum => "ETHEREUM",
            .solana => "SOLANA",
            .solana_devnet => "SOLANA_DEVNET",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
