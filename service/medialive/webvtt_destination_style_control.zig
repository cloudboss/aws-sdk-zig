const std = @import("std");

/// Webvtt Destination Style Control
pub const WebvttDestinationStyleControl = enum {
    no_style_data,
    passthrough,

    pub const json_field_names = .{
        .no_style_data = "NO_STYLE_DATA",
        .passthrough = "PASSTHROUGH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_style_data => "NO_STYLE_DATA",
            .passthrough => "PASSTHROUGH",
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
