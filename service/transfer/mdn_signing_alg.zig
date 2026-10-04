const std = @import("std");

pub const MdnSigningAlg = enum {
    sha256,
    sha384,
    sha512,
    sha1,
    none,
    default,

    pub const json_field_names = .{
        .sha256 = "SHA256",
        .sha384 = "SHA384",
        .sha512 = "SHA512",
        .sha1 = "SHA1",
        .none = "NONE",
        .default = "DEFAULT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sha256 => "SHA256",
            .sha384 => "SHA384",
            .sha512 => "SHA512",
            .sha1 => "SHA1",
            .none => "NONE",
            .default => "DEFAULT",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
