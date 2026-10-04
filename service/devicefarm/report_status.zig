const std = @import("std");

/// The status of an insights report. Possible values are:
///
/// * PENDING: The service has queued the report and generation has not started.
///
/// * RUNNING: The service is generating the report.
///
/// * COMPLETED: The service successfully generated the report.
///
/// * SKIPPED: The service did not generate the report because the necessary
///   conditions were not met. For more information about why the service could
///   not generate the report, view the `message` field in `TestReport` or
///   `JobReport`.
///
/// * ERRORED: An error occurred while generating the report. For more
///   information about why the service could not generate the report, view the
///   `message` field in `TestReport` or `JobReport`.
pub const ReportStatus = enum {
    pending,
    running,
    completed,
    skipped,
    errored,

    pub const json_field_names = .{
        .pending = "PENDING",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .skipped = "SKIPPED",
        .errored = "ERRORED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .running => "RUNNING",
            .completed => "COMPLETED",
            .skipped => "SKIPPED",
            .errored => "ERRORED",
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
