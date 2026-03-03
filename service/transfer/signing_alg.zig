const std = @import("std");

pub const SigningAlg = enum {
    sha256,
    sha384,
    sha512,
    sha1,
    none,

    pub const json_field_names = .{
        .sha256 = "SHA256",
        .sha384 = "SHA384",
        .sha512 = "SHA512",
        .sha1 = "SHA1",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sha256 => "SHA256",
            .sha384 => "SHA384",
            .sha512 => "SHA512",
            .sha1 => "SHA1",
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
