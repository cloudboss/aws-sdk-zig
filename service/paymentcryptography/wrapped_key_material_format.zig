const std = @import("std");

pub const WrappedKeyMaterialFormat = enum {
    key_cryptogram,
    tr31_key_block,
    tr34_key_block,

    pub const json_field_names = .{
        .key_cryptogram = "KEY_CRYPTOGRAM",
        .tr31_key_block = "TR31_KEY_BLOCK",
        .tr34_key_block = "TR34_KEY_BLOCK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .key_cryptogram => "KEY_CRYPTOGRAM",
            .tr31_key_block => "TR31_KEY_BLOCK",
            .tr34_key_block => "TR34_KEY_BLOCK",
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
