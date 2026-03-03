const std = @import("std");

pub const PrivateKeyAlgorithm = enum {
    rsa,
    ecdh_p256,
    ecdh_p384,
    ecdh_p521,

    pub const json_field_names = .{
        .rsa = "RSA",
        .ecdh_p256 = "ECDH_P256",
        .ecdh_p384 = "ECDH_P384",
        .ecdh_p521 = "ECDH_P521",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rsa => "RSA",
            .ecdh_p256 => "ECDH_P256",
            .ecdh_p384 => "ECDH_P384",
            .ecdh_p521 => "ECDH_P521",
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
