const std = @import("std");

/// To include a timecode track in your MP4 output: Choose Enabled. MediaConvert
/// writes the timecode track in the Null Media Header box (NMHD), without any
/// timecode text formatting information. You can also specify dropframe or
/// non-dropframe timecode under the Drop Frame Timecode setting. To not include
/// a timecode track: Keep the default value, Disabled.
pub const TimecodeTrack = enum {
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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
