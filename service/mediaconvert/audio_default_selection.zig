const std = @import("std");

/// Specify a fallback audio selector for this input. Use to ensure outputs have
/// audio even when the audio selector you specify in your output is missing
/// from the source. DEFAULT (Checked in the MediaConvert console): If your
/// output settings specify an audio selector that does not exist in this input,
/// MediaConvert uses this audio selector instead. This is useful when you have
/// multiple inputs with a different number of audio tracks. NOT_DEFAULT
/// (Unchecked in the MediaConvert console): MediaConvert will not fallback from
/// any missing audio selector. Any output specifying a missing audio selector
/// will be silent.
pub const AudioDefaultSelection = enum {
    default,
    not_default,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .not_default = "NOT_DEFAULT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .not_default => "NOT_DEFAULT",
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
