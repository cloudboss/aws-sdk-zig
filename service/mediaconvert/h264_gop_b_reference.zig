const std = @import("std");

/// Specify whether to allow B-frames to be referenced by other frame types. To
/// use reference B-frames when your GOP structure has 1 or more B-frames: Leave
/// blank or keep the default value Enabled. We recommend that you choose
/// Enabled to help improve the video quality of your output relative to its
/// bitrate. To not use reference B-frames: Choose Disabled.
pub const H264GopBReference = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .enabled => "ENABLED",
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
