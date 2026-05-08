const std = @import("std");

pub const PaymentConnectorType = enum {
    coinbase_cdp,
    stripe_privy,

    pub const json_field_names = .{
        .coinbase_cdp = "CoinbaseCDP",
        .stripe_privy = "StripePrivy",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .coinbase_cdp => "CoinbaseCDP",
            .stripe_privy => "StripePrivy",
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
