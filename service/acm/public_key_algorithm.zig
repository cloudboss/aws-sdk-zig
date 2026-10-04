const std = @import("std");

pub const PublicKeyAlgorithm = enum {
    rsa_2048,
    ec_prime256_v1,
    ec_secp384_r1,

    pub const json_field_names = .{
        .rsa_2048 = "RSA_2048",
        .ec_prime256_v1 = "EC_prime256v1",
        .ec_secp384_r1 = "EC_secp384r1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rsa_2048 => "RSA_2048",
            .ec_prime256_v1 => "EC_prime256v1",
            .ec_secp384_r1 => "EC_secp384r1",
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
