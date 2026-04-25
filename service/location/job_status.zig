const std = @import("std");

pub const JobStatus = enum {
    /// The job has not yet started.
    pending,
    /// The job is currently running.
    running,
    /// The job has processed all records and is complete.
    completed,
    /// The job has failed to process all records.
    failed,
    /// The job is being cancelled.
    cancelling,
    /// The job has been cancelled and cannot be resumed.
    cancelled,

    pub const json_field_names = .{
        .pending = "Pending",
        .running = "Running",
        .completed = "Completed",
        .failed = "Failed",
        .cancelling = "Cancelling",
        .cancelled = "Cancelled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .running => "Running",
            .completed => "Completed",
            .failed => "Failed",
            .cancelling => "Cancelling",
            .cancelled => "Cancelled",
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
