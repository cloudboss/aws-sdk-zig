const std = @import("std");

/// The image format for a browser screenshot.
pub const ScreenshotFormat = enum {
    png,

    pub const json_field_names = .{
        .png = "PNG",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .png => "PNG",
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
