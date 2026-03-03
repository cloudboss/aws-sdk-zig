const std = @import("std");

pub const QueryNetwork = enum {
    /// Ethereum main network
    ethereum_mainnet,
    /// SEPOLIA network (ethereum testnet)
    ethereum_sepolia_testnet,
    /// Bitcoin main network
    bitcoin_mainnet,
    /// Bitcoin test network
    bitcoin_testnet,

    pub const json_field_names = .{
        .ethereum_mainnet = "ETHEREUM_MAINNET",
        .ethereum_sepolia_testnet = "ETHEREUM_SEPOLIA_TESTNET",
        .bitcoin_mainnet = "BITCOIN_MAINNET",
        .bitcoin_testnet = "BITCOIN_TESTNET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ethereum_mainnet => "ETHEREUM_MAINNET",
            .ethereum_sepolia_testnet => "ETHEREUM_SEPOLIA_TESTNET",
            .bitcoin_mainnet => "BITCOIN_MAINNET",
            .bitcoin_testnet => "BITCOIN_TESTNET",
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
