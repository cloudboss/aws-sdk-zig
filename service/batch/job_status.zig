const std = @import("std");

pub const JobStatus = enum {
    submitted,
    pending,
    runnable,
    starting,
    running,
    succeeded,
    failed,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .pending = "PENDING",
        .runnable = "RUNNABLE",
        .starting = "STARTING",
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "SUBMITTED",
            .pending => "PENDING",
            .runnable => "RUNNABLE",
            .starting => "STARTING",
            .running => "RUNNING",
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
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
