const std = @import("std");

pub const SigningAlgorithm = enum {
    sha256_withecdsa,
    sha384_withecdsa,
    sha512_withecdsa,
    sha256_withrsa,
    sha384_withrsa,
    sha512_withrsa,
    sm3_withsm2,
    ml_dsa_44,
    ml_dsa_65,
    ml_dsa_87,

    pub const json_field_names = .{
        .sha256_withecdsa = "SHA256WITHECDSA",
        .sha384_withecdsa = "SHA384WITHECDSA",
        .sha512_withecdsa = "SHA512WITHECDSA",
        .sha256_withrsa = "SHA256WITHRSA",
        .sha384_withrsa = "SHA384WITHRSA",
        .sha512_withrsa = "SHA512WITHRSA",
        .sm3_withsm2 = "SM3WITHSM2",
        .ml_dsa_44 = "ML_DSA_44",
        .ml_dsa_65 = "ML_DSA_65",
        .ml_dsa_87 = "ML_DSA_87",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sha256_withecdsa => "SHA256WITHECDSA",
            .sha384_withecdsa => "SHA384WITHECDSA",
            .sha512_withecdsa => "SHA512WITHECDSA",
            .sha256_withrsa => "SHA256WITHRSA",
            .sha384_withrsa => "SHA384WITHRSA",
            .sha512_withrsa => "SHA512WITHRSA",
            .sm3_withsm2 => "SM3WITHSM2",
            .ml_dsa_44 => "ML_DSA_44",
            .ml_dsa_65 => "ML_DSA_65",
            .ml_dsa_87 => "ML_DSA_87",
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
