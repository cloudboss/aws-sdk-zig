const std = @import("std");

pub const KeyMaterialType = enum {
    tr34_key_block,
    tr31_key_block,
    root_public_key_certificate,
    trusted_public_key_certificate,
    key_cryptogram,

    pub const json_field_names = .{
        .tr34_key_block = "TR34_KEY_BLOCK",
        .tr31_key_block = "TR31_KEY_BLOCK",
        .root_public_key_certificate = "ROOT_PUBLIC_KEY_CERTIFICATE",
        .trusted_public_key_certificate = "TRUSTED_PUBLIC_KEY_CERTIFICATE",
        .key_cryptogram = "KEY_CRYPTOGRAM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tr34_key_block => "TR34_KEY_BLOCK",
            .tr31_key_block => "TR31_KEY_BLOCK",
            .root_public_key_certificate => "ROOT_PUBLIC_KEY_CERTIFICATE",
            .trusted_public_key_certificate => "TRUSTED_PUBLIC_KEY_CERTIFICATE",
            .key_cryptogram => "KEY_CRYPTOGRAM",
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
