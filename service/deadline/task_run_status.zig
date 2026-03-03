const std = @import("std");

pub const TaskRunStatus = enum {
    pending,
    ready,
    assigned,
    starting,
    scheduled,
    interrupting,
    running,
    suspended,
    canceled,
    failed,
    succeeded,
    not_compatible,

    pub const json_field_names = .{
        .pending = "PENDING",
        .ready = "READY",
        .assigned = "ASSIGNED",
        .starting = "STARTING",
        .scheduled = "SCHEDULED",
        .interrupting = "INTERRUPTING",
        .running = "RUNNING",
        .suspended = "SUSPENDED",
        .canceled = "CANCELED",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .not_compatible = "NOT_COMPATIBLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .ready => "READY",
            .assigned => "ASSIGNED",
            .starting => "STARTING",
            .scheduled => "SCHEDULED",
            .interrupting => "INTERRUPTING",
            .running => "RUNNING",
            .suspended => "SUSPENDED",
            .canceled => "CANCELED",
            .failed => "FAILED",
            .succeeded => "SUCCEEDED",
            .not_compatible => "NOT_COMPATIBLE",
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
