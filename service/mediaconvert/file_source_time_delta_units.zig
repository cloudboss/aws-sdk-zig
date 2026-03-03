const std = @import("std");

/// When you use the setting Time delta to adjust the sync between your sidecar
/// captions and your video, use this setting to specify the units for the delta
/// that you specify. When you don't specify a value for Time delta units,
/// MediaConvert uses seconds by default.
pub const FileSourceTimeDeltaUnits = enum {
    seconds,
    milliseconds,

    pub const json_field_names = .{
        .seconds = "SECONDS",
        .milliseconds = "MILLISECONDS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .seconds => "SECONDS",
            .milliseconds => "MILLISECONDS",
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
