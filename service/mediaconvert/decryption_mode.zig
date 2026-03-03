const std = @import("std");

/// Specify the encryption mode that you used to encrypt your input files.
pub const DecryptionMode = enum {
    aes_ctr,
    aes_cbc,
    aes_gcm,

    pub const json_field_names = .{
        .aes_ctr = "AES_CTR",
        .aes_cbc = "AES_CBC",
        .aes_gcm = "AES_GCM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aes_ctr => "AES_CTR",
            .aes_cbc => "AES_CBC",
            .aes_gcm => "AES_GCM",
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
