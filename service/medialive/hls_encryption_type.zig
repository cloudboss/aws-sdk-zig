const std = @import("std");

/// Hls Encryption Type
pub const HlsEncryptionType = enum {
    aes128,
    sample_aes,

    pub const json_field_names = .{
        .aes128 = "AES128",
        .sample_aes = "SAMPLE_AES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aes128 => "AES128",
            .sample_aes => "SAMPLE_AES",
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
