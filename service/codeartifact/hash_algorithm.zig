const std = @import("std");

pub const HashAlgorithm = enum {
    md5,
    sha1,
    sha256,
    sha512,

    pub const json_field_names = .{
        .md5 = "MD5",
        .sha1 = "SHA-1",
        .sha256 = "SHA-256",
        .sha512 = "SHA-512",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .md5 => "MD5",
            .sha1 => "SHA-1",
            .sha256 => "SHA-256",
            .sha512 => "SHA-512",
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
