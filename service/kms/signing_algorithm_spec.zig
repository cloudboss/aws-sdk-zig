const std = @import("std");

pub const SigningAlgorithmSpec = enum {
    rsassa_pss_sha_256,
    rsassa_pss_sha_384,
    rsassa_pss_sha_512,
    rsassa_pkcs1_v1_5_sha_256,
    rsassa_pkcs1_v1_5_sha_384,
    rsassa_pkcs1_v1_5_sha_512,
    ecdsa_sha_256,
    ecdsa_sha_384,
    ecdsa_sha_512,
    sm2_dsa,
    ml_dsa_shake_256,
    ed25519_sha_512,
    ed25519_ph_sha_512,

    pub const json_field_names = .{
        .rsassa_pss_sha_256 = "RSASSA_PSS_SHA_256",
        .rsassa_pss_sha_384 = "RSASSA_PSS_SHA_384",
        .rsassa_pss_sha_512 = "RSASSA_PSS_SHA_512",
        .rsassa_pkcs1_v1_5_sha_256 = "RSASSA_PKCS1_V1_5_SHA_256",
        .rsassa_pkcs1_v1_5_sha_384 = "RSASSA_PKCS1_V1_5_SHA_384",
        .rsassa_pkcs1_v1_5_sha_512 = "RSASSA_PKCS1_V1_5_SHA_512",
        .ecdsa_sha_256 = "ECDSA_SHA_256",
        .ecdsa_sha_384 = "ECDSA_SHA_384",
        .ecdsa_sha_512 = "ECDSA_SHA_512",
        .sm2_dsa = "SM2DSA",
        .ml_dsa_shake_256 = "ML_DSA_SHAKE_256",
        .ed25519_sha_512 = "ED25519_SHA_512",
        .ed25519_ph_sha_512 = "ED25519_PH_SHA_512",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rsassa_pss_sha_256 => "RSASSA_PSS_SHA_256",
            .rsassa_pss_sha_384 => "RSASSA_PSS_SHA_384",
            .rsassa_pss_sha_512 => "RSASSA_PSS_SHA_512",
            .rsassa_pkcs1_v1_5_sha_256 => "RSASSA_PKCS1_V1_5_SHA_256",
            .rsassa_pkcs1_v1_5_sha_384 => "RSASSA_PKCS1_V1_5_SHA_384",
            .rsassa_pkcs1_v1_5_sha_512 => "RSASSA_PKCS1_V1_5_SHA_512",
            .ecdsa_sha_256 => "ECDSA_SHA_256",
            .ecdsa_sha_384 => "ECDSA_SHA_384",
            .ecdsa_sha_512 => "ECDSA_SHA_512",
            .sm2_dsa => "SM2DSA",
            .ml_dsa_shake_256 => "ML_DSA_SHAKE_256",
            .ed25519_sha_512 => "ED25519_SHA_512",
            .ed25519_ph_sha_512 => "ED25519_PH_SHA_512",
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
