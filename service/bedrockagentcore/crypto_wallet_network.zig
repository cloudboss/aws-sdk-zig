const std = @import("std");

/// Supported blockchain networks for crypto wallets
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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
