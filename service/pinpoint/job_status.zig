const std = @import("std");

pub const JobStatus = enum {
    created,
    preparing_for_initialization,
    initializing,
    processing,
    pending_job,
    completing,
    completed,
    failing,
    failed,

    pub const json_field_names = .{
        .created = "CREATED",
        .preparing_for_initialization = "PREPARING_FOR_INITIALIZATION",
        .initializing = "INITIALIZING",
        .processing = "PROCESSING",
        .pending_job = "PENDING_JOB",
        .completing = "COMPLETING",
        .completed = "COMPLETED",
        .failing = "FAILING",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .preparing_for_initialization => "PREPARING_FOR_INITIALIZATION",
            .initializing => "INITIALIZING",
            .processing => "PROCESSING",
            .pending_job => "PENDING_JOB",
            .completing => "COMPLETING",
            .completed => "COMPLETED",
            .failing => "FAILING",
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
