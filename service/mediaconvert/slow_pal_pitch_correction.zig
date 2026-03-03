const std = @import("std");

/// Use Slow PAL pitch correction to compensate for audio pitch changes during
/// slow PAL frame rate conversion. This setting only applies when Slow PAL is
/// enabled in your output video codec settings. To automatically apply audio
/// pitch correction: Choose Enabled. MediaConvert automatically applies a pitch
/// correction to your output to match the original content's audio pitch. To
/// not apply audio pitch correction: Keep the default value, Disabled.
pub const SlowPalPitchCorrection = enum {
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
