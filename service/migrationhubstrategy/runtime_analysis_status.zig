const std = @import("std");

pub const RuntimeAnalysisStatus = enum {
    analysis_to_be_scheduled,
    analysis_started,
    analysis_success,
    analysis_failed,

    pub const json_field_names = .{
        .analysis_to_be_scheduled = "ANALYSIS_TO_BE_SCHEDULED",
        .analysis_started = "ANALYSIS_STARTED",
        .analysis_success = "ANALYSIS_SUCCESS",
        .analysis_failed = "ANALYSIS_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .analysis_to_be_scheduled => "ANALYSIS_TO_BE_SCHEDULED",
            .analysis_started => "ANALYSIS_STARTED",
            .analysis_success => "ANALYSIS_SUCCESS",
            .analysis_failed => "ANALYSIS_FAILED",
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
