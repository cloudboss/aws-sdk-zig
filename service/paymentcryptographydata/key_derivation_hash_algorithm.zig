const std = @import("std");

pub const KeyDerivationHashAlgorithm = enum {
    sha_256,
    sha_384,
    sha_512,

    pub const json_field_names = .{
        .sha_256 = "SHA_256",
        .sha_384 = "SHA_384",
        .sha_512 = "SHA_512",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sha_256 => "SHA_256",
            .sha_384 => "SHA_384",
            .sha_512 => "SHA_512",
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
