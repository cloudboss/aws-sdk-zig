const std = @import("std");

/// The status of a dataset export job.
pub const DatasetExportJobStatus = enum {
    submitted,
    running,
    completed,
    completed_with_errors,
    failed,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .completed_with_errors = "COMPLETED_WITH_ERRORS",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "SUBMITTED",
            .running => "RUNNING",
            .completed => "COMPLETED",
            .completed_with_errors => "COMPLETED_WITH_ERRORS",
            .failed => "FAILED",
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
