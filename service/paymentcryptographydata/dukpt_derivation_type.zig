const std = @import("std");

pub const DukptDerivationType = enum {
    tdes_2_key,
    tdes_3_key,
    aes_128,
    aes_192,
    aes_256,

    pub const json_field_names = .{
        .tdes_2_key = "TDES_2KEY",
        .tdes_3_key = "TDES_3KEY",
        .aes_128 = "AES_128",
        .aes_192 = "AES_192",
        .aes_256 = "AES_256",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tdes_2_key => "TDES_2KEY",
            .tdes_3_key => "TDES_3KEY",
            .aes_128 => "AES_128",
            .aes_192 => "AES_192",
            .aes_256 => "AES_256",
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
