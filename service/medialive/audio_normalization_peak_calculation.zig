const std = @import("std");

/// Audio Normalization Peak Calculation
pub const AudioNormalizationPeakCalculation = enum {
    none,
    true_peak,

    pub const json_field_names = .{
        .none = "NONE",
        .true_peak = "TRUE_PEAK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .true_peak => "TRUE_PEAK",
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
