const std = @import("std");

/// Specify how MediaConvert writes style information in your output WebVTT
/// captions. To use the available style, color, and position information from
/// your input captions: Choose Enabled. MediaConvert uses default settings when
/// style and position information is missing from your input captions. To
/// recreate the input captions exactly: Choose Strict. MediaConvert
/// automatically applies timing adjustments, including adjustments for frame
/// rate conversion, ad avails, and input clipping. Your input captions format
/// must be WebVTT. To ignore the style and position information from your input
/// captions and use simplified output captions: Keep the default value,
/// Disabled. Or leave blank. To use the available style, color, and position
/// information from your input captions, while merging cues with identical time
/// ranges: Choose merge. This setting can help prevent positioning overlaps for
/// certain players that expect a single single cue for any given time range.
pub const WebvttStylePassthrough = enum {
    enabled,
    disabled,
    strict,
    merge,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .strict = "STRICT",
        .merge = "MERGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .disabled => "DISABLED",
            .strict => "STRICT",
            .merge => "MERGE",
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
