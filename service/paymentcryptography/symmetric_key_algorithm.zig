const std = @import("std");

pub const SymmetricKeyAlgorithm = enum {
    tdes_2_key,
    tdes_3_key,
    aes_128,
    aes_192,
    aes_256,
    hmac_sha256,
    hmac_sha384,
    hmac_sha512,
    hmac_sha224,

    pub const json_field_names = .{
        .tdes_2_key = "TDES_2KEY",
        .tdes_3_key = "TDES_3KEY",
        .aes_128 = "AES_128",
        .aes_192 = "AES_192",
        .aes_256 = "AES_256",
        .hmac_sha256 = "HMAC_SHA256",
        .hmac_sha384 = "HMAC_SHA384",
        .hmac_sha512 = "HMAC_SHA512",
        .hmac_sha224 = "HMAC_SHA224",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tdes_2_key => "TDES_2KEY",
            .tdes_3_key => "TDES_3KEY",
            .aes_128 => "AES_128",
            .aes_192 => "AES_192",
            .aes_256 => "AES_256",
            .hmac_sha256 => "HMAC_SHA256",
            .hmac_sha384 => "HMAC_SHA384",
            .hmac_sha512 => "HMAC_SHA512",
            .hmac_sha224 => "HMAC_SHA224",
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
