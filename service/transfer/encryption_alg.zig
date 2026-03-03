const std = @import("std");

pub const EncryptionAlg = enum {
    aes128_cbc,
    aes192_cbc,
    aes256_cbc,
    des_ede3_cbc,
    none,

    pub const json_field_names = .{
        .aes128_cbc = "AES128_CBC",
        .aes192_cbc = "AES192_CBC",
        .aes256_cbc = "AES256_CBC",
        .des_ede3_cbc = "DES_EDE3_CBC",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aes128_cbc => "AES128_CBC",
            .aes192_cbc => "AES192_CBC",
            .aes256_cbc => "AES256_CBC",
            .des_ede3_cbc => "DES_EDE3_CBC",
            .none => "NONE",
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
