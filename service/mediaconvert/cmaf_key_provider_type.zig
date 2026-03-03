const std = @import("std");

/// Specify whether your DRM encryption key is static or from a key provider
/// that follows the SPEKE standard. For more information about SPEKE, see
/// https://docs.aws.amazon.com/speke/latest/documentation/what-is-speke.html.
pub const CmafKeyProviderType = enum {
    speke,
    static_key,

    pub const json_field_names = .{
        .speke = "SPEKE",
        .static_key = "STATIC_KEY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .speke => "SPEKE",
            .static_key => "STATIC_KEY",
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
