const std = @import("std");

/// Payment type enum.
pub const PaymentType = enum {
    crypto_x402,
    mpp,

    pub const json_field_names = .{
        .crypto_x402 = "CRYPTO_X402",
        .mpp = "MPP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .crypto_x402 => "CRYPTO_X402",
            .mpp => "MPP",
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
