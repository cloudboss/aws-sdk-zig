const std = @import("std");

pub const PaddingType = enum {
    pkcs1,
    oaep_sha1,
    oaep_sha256,
    oaep_sha512,

    pub const json_field_names = .{
        .pkcs1 = "PKCS1",
        .oaep_sha1 = "OAEP_SHA1",
        .oaep_sha256 = "OAEP_SHA256",
        .oaep_sha512 = "OAEP_SHA512",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pkcs1 => "PKCS1",
            .oaep_sha1 => "OAEP_SHA1",
            .oaep_sha256 => "OAEP_SHA256",
            .oaep_sha512 => "OAEP_SHA512",
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
