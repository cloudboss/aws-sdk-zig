const std = @import("std");

/// Defines the Algorithm used to generate the certificate signing request
pub const SigningAlgorithmType = enum {
    sha224,
    sha256,
    sha384,
    sha512,

    pub const json_field_names = .{
        .sha224 = "SHA224",
        .sha256 = "SHA256",
        .sha384 = "SHA384",
        .sha512 = "SHA512",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sha224 => "SHA224",
            .sha256 => "SHA256",
            .sha384 => "SHA384",
            .sha512 => "SHA512",
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
