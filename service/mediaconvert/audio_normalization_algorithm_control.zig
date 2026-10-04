const std = @import("std");

/// When enabled the output audio is corrected using the chosen algorithm. If
/// disabled, the audio will be measured but not adjusted.
pub const AudioNormalizationAlgorithmControl = enum {
    correct_audio,
    measure_only,

    pub const json_field_names = .{
        .correct_audio = "CORRECT_AUDIO",
        .measure_only = "MEASURE_ONLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .correct_audio => "CORRECT_AUDIO",
            .measure_only => "MEASURE_ONLY",
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
