const std = @import("std");

pub const EventType = enum {
    scheduled_assessment_failure,
    drift_detected,

    pub const json_field_names = .{
        .scheduled_assessment_failure = "ScheduledAssessmentFailure",
        .drift_detected = "DriftDetected",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scheduled_assessment_failure => "ScheduledAssessmentFailure",
            .drift_detected => "DriftDetected",
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
