const std = @import("std");

pub const CoinbaseCdpSecret = enum {
    api_key,
    wallet_secret,

    pub const json_field_names = .{
        .api_key = "API_KEY",
        .wallet_secret = "WALLET_SECRET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .api_key => "API_KEY",
            .wallet_secret => "WALLET_SECRET",
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
