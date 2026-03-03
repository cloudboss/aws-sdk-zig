const std = @import("std");

/// The encryption method to use.
pub const CmafEncryptionMethod = enum {
    sample_aes,
    aes_ctr,

    pub const json_field_names = .{
        .sample_aes = "SAMPLE_AES",
        .aes_ctr = "AES_CTR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sample_aes => "SAMPLE_AES",
            .aes_ctr => "AES_CTR",
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
