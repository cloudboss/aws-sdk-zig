const std = @import("std");

pub const WrappingKeySpec = enum {
    rsa_2048,
    rsa_3072,
    rsa_4096,
    sm2,

    pub const json_field_names = .{
        .rsa_2048 = "RSA_2048",
        .rsa_3072 = "RSA_3072",
        .rsa_4096 = "RSA_4096",
        .sm2 = "SM2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rsa_2048 => "RSA_2048",
            .rsa_3072 => "RSA_3072",
            .rsa_4096 => "RSA_4096",
            .sm2 => "SM2",
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
