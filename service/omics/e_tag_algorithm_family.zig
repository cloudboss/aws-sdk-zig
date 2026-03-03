const std = @import("std");

pub const ETagAlgorithmFamily = enum {
    md5_up,
    sha256_up,
    sha512_up,

    pub const json_field_names = .{
        .md5_up = "MD5up",
        .sha256_up = "SHA256up",
        .sha512_up = "SHA512up",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .md5_up => "MD5up",
            .sha256_up => "SHA256up",
            .sha512_up => "SHA512up",
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
