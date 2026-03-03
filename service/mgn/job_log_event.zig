const std = @import("std");

pub const JobLogEvent = enum {
    job_start,
    server_skipped,
    cleanup_start,
    cleanup_end,
    cleanup_fail,
    snapshot_start,
    snapshot_end,
    snapshot_fail,
    using_previous_snapshot,
    conversion_start,
    conversion_end,
    conversion_fail,
    launch_start,
    launch_failed,
    job_cancel,
    job_end,

    pub const json_field_names = .{
        .job_start = "JOB_START",
        .server_skipped = "SERVER_SKIPPED",
        .cleanup_start = "CLEANUP_START",
        .cleanup_end = "CLEANUP_END",
        .cleanup_fail = "CLEANUP_FAIL",
        .snapshot_start = "SNAPSHOT_START",
        .snapshot_end = "SNAPSHOT_END",
        .snapshot_fail = "SNAPSHOT_FAIL",
        .using_previous_snapshot = "USING_PREVIOUS_SNAPSHOT",
        .conversion_start = "CONVERSION_START",
        .conversion_end = "CONVERSION_END",
        .conversion_fail = "CONVERSION_FAIL",
        .launch_start = "LAUNCH_START",
        .launch_failed = "LAUNCH_FAILED",
        .job_cancel = "JOB_CANCEL",
        .job_end = "JOB_END",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .job_start => "JOB_START",
            .server_skipped => "SERVER_SKIPPED",
            .cleanup_start => "CLEANUP_START",
            .cleanup_end => "CLEANUP_END",
            .cleanup_fail => "CLEANUP_FAIL",
            .snapshot_start => "SNAPSHOT_START",
            .snapshot_end => "SNAPSHOT_END",
            .snapshot_fail => "SNAPSHOT_FAIL",
            .using_previous_snapshot => "USING_PREVIOUS_SNAPSHOT",
            .conversion_start => "CONVERSION_START",
            .conversion_end => "CONVERSION_END",
            .conversion_fail => "CONVERSION_FAIL",
            .launch_start => "LAUNCH_START",
            .launch_failed => "LAUNCH_FAILED",
            .job_cancel => "JOB_CANCEL",
            .job_end => "JOB_END",
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
