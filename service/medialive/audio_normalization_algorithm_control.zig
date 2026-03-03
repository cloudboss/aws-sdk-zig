const std = @import("std");

/// Audio Normalization Algorithm Control
pub const AudioNormalizationAlgorithmControl = enum {
    correct_audio,

    pub const json_field_names = .{
        .correct_audio = "CORRECT_AUDIO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .correct_audio => "CORRECT_AUDIO",
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
