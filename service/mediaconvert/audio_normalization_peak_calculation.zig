const std = @import("std");

/// If set to TRUE_PEAK, calculate and log the TruePeak for each output's audio
/// track loudness.
pub const AudioNormalizationPeakCalculation = enum {
    true_peak,
    none,

    pub const json_field_names = .{
        .true_peak = "TRUE_PEAK",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .true_peak => "TRUE_PEAK",
            .none => "NONE",
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
