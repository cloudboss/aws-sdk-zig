const std = @import("std");

pub const ToolbarItem = enum {
    windows,
    dual_monitor,
    full_screen,
    webcam,
    microphone,

    pub const json_field_names = .{
        .windows = "Windows",
        .dual_monitor = "DualMonitor",
        .full_screen = "FullScreen",
        .webcam = "Webcam",
        .microphone = "Microphone",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .windows => "Windows",
            .dual_monitor => "DualMonitor",
            .full_screen => "FullScreen",
            .webcam => "Webcam",
            .microphone => "Microphone",
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
