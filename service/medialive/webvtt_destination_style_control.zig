const std = @import("std");

/// Webvtt Destination Style Control
pub const WebvttDestinationStyleControl = enum {
    no_style_data,
    passthrough,
    manual,

    pub const json_field_names = .{
        .no_style_data = "NO_STYLE_DATA",
        .passthrough = "PASSTHROUGH",
        .manual = "MANUAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_style_data => "NO_STYLE_DATA",
            .passthrough => "PASSTHROUGH",
            .manual => "MANUAL",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
