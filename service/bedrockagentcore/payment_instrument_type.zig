const std = @import("std");

/// The type of payment instrument.
pub const PaymentInstrumentType = enum {
    embedded_crypto_wallet,

    pub const json_field_names = .{
        .embedded_crypto_wallet = "EMBEDDED_CRYPTO_WALLET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .embedded_crypto_wallet => "EMBEDDED_CRYPTO_WALLET",
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
