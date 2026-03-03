const std = @import("std");

pub const JobRunState = enum {
    submitted,
    pending,
    scheduled,
    running,
    success,
    failed,
    cancelling,
    cancelled,
    queued,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .pending = "PENDING",
        .scheduled = "SCHEDULED",
        .running = "RUNNING",
        .success = "SUCCESS",
        .failed = "FAILED",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
        .queued = "QUEUED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "SUBMITTED",
            .pending => "PENDING",
            .scheduled => "SCHEDULED",
            .running => "RUNNING",
            .success => "SUCCESS",
            .failed => "FAILED",
            .cancelling => "CANCELLING",
            .cancelled => "CANCELLED",
            .queued => "QUEUED",
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
