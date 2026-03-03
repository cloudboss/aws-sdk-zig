const std = @import("std");

pub const WrappingKeySpec = enum {
    rsa_oaep_sha_256,
    rsa_oaep_sha_512,

    pub const json_field_names = .{
        .rsa_oaep_sha_256 = "RSA_OAEP_SHA_256",
        .rsa_oaep_sha_512 = "RSA_OAEP_SHA_512",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rsa_oaep_sha_256 => "RSA_OAEP_SHA_256",
            .rsa_oaep_sha_512 => "RSA_OAEP_SHA_512",
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
