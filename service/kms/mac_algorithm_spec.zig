const std = @import("std");

pub const MacAlgorithmSpec = enum {
    hmac_sha_224,
    hmac_sha_256,
    hmac_sha_384,
    hmac_sha_512,

    pub const json_field_names = .{
        .hmac_sha_224 = "HMAC_SHA_224",
        .hmac_sha_256 = "HMAC_SHA_256",
        .hmac_sha_384 = "HMAC_SHA_384",
        .hmac_sha_512 = "HMAC_SHA_512",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hmac_sha_224 => "HMAC_SHA_224",
            .hmac_sha_256 => "HMAC_SHA_256",
            .hmac_sha_384 => "HMAC_SHA_384",
            .hmac_sha_512 => "HMAC_SHA_512",
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
