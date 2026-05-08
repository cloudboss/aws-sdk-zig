const std = @import("std");

/// Payment type enum
pub const PaymentType = enum {
    crypto_x402,

    pub const json_field_names = .{
        .crypto_x402 = "CRYPTO_X402",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .crypto_x402 => "CRYPTO_X402",
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
