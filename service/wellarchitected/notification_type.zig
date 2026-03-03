const std = @import("std");

pub const NotificationType = enum {
    lens_version_upgraded,
    lens_version_deprecated,

    pub const json_field_names = .{
        .lens_version_upgraded = "LENS_VERSION_UPGRADED",
        .lens_version_deprecated = "LENS_VERSION_DEPRECATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .lens_version_upgraded => "LENS_VERSION_UPGRADED",
            .lens_version_deprecated => "LENS_VERSION_DEPRECATED",
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
