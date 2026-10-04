const std = @import("std");

pub const BlockchainChain = enum {
    base,
    solana,
    base_sepolia,
    solana_devnet,

    pub const json_field_names = .{
        .base = "BASE",
        .solana = "SOLANA",
        .base_sepolia = "BASE_SEPOLIA",
        .solana_devnet = "SOLANA_DEVNET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .base => "BASE",
            .solana => "SOLANA",
            .base_sepolia => "BASE_SEPOLIA",
            .solana_devnet => "SOLANA_DEVNET",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
