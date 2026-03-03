const std = @import("std");

/// Thumbnail type.
pub const ThumbnailType = enum {
    unspecified,
    current_active,

    pub const json_field_names = .{
        .unspecified = "UNSPECIFIED",
        .current_active = "CURRENT_ACTIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unspecified => "UNSPECIFIED",
            .current_active => "CURRENT_ACTIVE",
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
