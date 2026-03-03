const std = @import("std");

/// The status of a job.
///
/// * `CREATED` – Job has just been created.
///
/// * `PROCESSING` – Job is processing.
///
/// * `ERROR` – An error occurred during processing.
///
/// * `COMPLETED` – Job has completed processing successfully.
pub const JobStatus = enum {
    created,
    processing,
    completed,
    failed,
    cancelled,

    pub const json_field_names = .{
        .created = "CREATED",
        .processing = "PROCESSING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .processing => "PROCESSING",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .cancelled => "CANCELLED",
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
