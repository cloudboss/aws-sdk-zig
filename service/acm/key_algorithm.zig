const std = @import("std");

pub const KeyAlgorithm = enum {
    rsa_1024,
    rsa_2048,
    rsa_3072,
    rsa_4096,
    ec_prime_256_v_1,
    ec_secp_384_r_1,
    ec_secp_521_r_1,

    pub const json_field_names = .{
        .rsa_1024 = "RSA_1024",
        .rsa_2048 = "RSA_2048",
        .rsa_3072 = "RSA_3072",
        .rsa_4096 = "RSA_4096",
        .ec_prime_256_v_1 = "EC_prime256v1",
        .ec_secp_384_r_1 = "EC_secp384r1",
        .ec_secp_521_r_1 = "EC_secp521r1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rsa_1024 => "RSA_1024",
            .rsa_2048 => "RSA_2048",
            .rsa_3072 => "RSA_3072",
            .rsa_4096 => "RSA_4096",
            .ec_prime_256_v_1 => "EC_prime256v1",
            .ec_secp_384_r_1 => "EC_secp384r1",
            .ec_secp_521_r_1 => "EC_secp521r1",
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
