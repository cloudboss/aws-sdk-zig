const std = @import("std");

pub const KeySpec = enum {
    rsa_2048,
    rsa_3072,
    rsa_4096,
    ecc_nist_p256,
    ecc_nist_p384,
    ecc_nist_p521,
    ecc_secg_p256_k1,
    symmetric_default,
    hmac_224,
    hmac_256,
    hmac_384,
    hmac_512,
    sm2,
    ml_dsa_44,
    ml_dsa_65,
    ml_dsa_87,
    ecc_nist_edwards25519,

    pub const json_field_names = .{
        .rsa_2048 = "RSA_2048",
        .rsa_3072 = "RSA_3072",
        .rsa_4096 = "RSA_4096",
        .ecc_nist_p256 = "ECC_NIST_P256",
        .ecc_nist_p384 = "ECC_NIST_P384",
        .ecc_nist_p521 = "ECC_NIST_P521",
        .ecc_secg_p256_k1 = "ECC_SECG_P256K1",
        .symmetric_default = "SYMMETRIC_DEFAULT",
        .hmac_224 = "HMAC_224",
        .hmac_256 = "HMAC_256",
        .hmac_384 = "HMAC_384",
        .hmac_512 = "HMAC_512",
        .sm2 = "SM2",
        .ml_dsa_44 = "ML_DSA_44",
        .ml_dsa_65 = "ML_DSA_65",
        .ml_dsa_87 = "ML_DSA_87",
        .ecc_nist_edwards25519 = "ECC_NIST_EDWARDS25519",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rsa_2048 => "RSA_2048",
            .rsa_3072 => "RSA_3072",
            .rsa_4096 => "RSA_4096",
            .ecc_nist_p256 => "ECC_NIST_P256",
            .ecc_nist_p384 => "ECC_NIST_P384",
            .ecc_nist_p521 => "ECC_NIST_P521",
            .ecc_secg_p256_k1 => "ECC_SECG_P256K1",
            .symmetric_default => "SYMMETRIC_DEFAULT",
            .hmac_224 => "HMAC_224",
            .hmac_256 => "HMAC_256",
            .hmac_384 => "HMAC_384",
            .hmac_512 => "HMAC_512",
            .sm2 => "SM2",
            .ml_dsa_44 => "ML_DSA_44",
            .ml_dsa_65 => "ML_DSA_65",
            .ml_dsa_87 => "ML_DSA_87",
            .ecc_nist_edwards25519 => "ECC_NIST_EDWARDS25519",
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
