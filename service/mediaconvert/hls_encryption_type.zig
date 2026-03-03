const std = @import("std");

/// Encrypts the segments with the given encryption scheme. Leave blank to
/// disable. Selecting 'Disabled' in the web interface also disables encryption.
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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
