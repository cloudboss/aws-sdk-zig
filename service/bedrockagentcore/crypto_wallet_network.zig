const std = @import("std");

/// Supported blockchain networks for crypto wallets.
pub const CryptoWalletNetwork = enum {
    ethereum,
    solana,

    pub const json_field_names = .{
        .ethereum = "ETHEREUM",
        .solana = "SOLANA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ethereum => "ETHEREUM",
            .solana => "SOLANA",
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
