const std = @import("std");

pub const EncryptionAlgorithmSpec = enum {
    symmetric_default,
    rsaes_oaep_sha_1,
    rsaes_oaep_sha_256,
    sm2_pke,

    pub const json_field_names = .{
        .symmetric_default = "SYMMETRIC_DEFAULT",
        .rsaes_oaep_sha_1 = "RSAES_OAEP_SHA_1",
        .rsaes_oaep_sha_256 = "RSAES_OAEP_SHA_256",
        .sm2_pke = "SM2PKE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .symmetric_default => "SYMMETRIC_DEFAULT",
            .rsaes_oaep_sha_1 => "RSAES_OAEP_SHA_1",
            .rsaes_oaep_sha_256 => "RSAES_OAEP_SHA_256",
            .sm2_pke => "SM2PKE",
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
