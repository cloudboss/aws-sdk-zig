const std = @import("std");

/// Supported vendor types for payment providers using non-standard auth
/// protocols
pub const PaymentCredentialProviderVendorType = enum {
    /// Coinbase Developer Platform - https://docs.cdp.coinbase.com/
    coinbase_cdp,
    /// Stripe + Privy - https://docs.privy.io/
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
