const std = @import("std");

pub const ModelQuality = enum {
    quality_threshold_met,
    cannot_determine_quality,
    poor_quality_detected,

    pub const json_field_names = .{
        .quality_threshold_met = "QUALITY_THRESHOLD_MET",
        .cannot_determine_quality = "CANNOT_DETERMINE_QUALITY",
        .poor_quality_detected = "POOR_QUALITY_DETECTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .quality_threshold_met => "QUALITY_THRESHOLD_MET",
            .cannot_determine_quality => "CANNOT_DETERMINE_QUALITY",
            .poor_quality_detected => "POOR_QUALITY_DETECTED",
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
