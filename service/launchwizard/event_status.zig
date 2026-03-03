const std = @import("std");

pub const EventStatus = enum {
    canceled,
    canceling,
    completed,
    created,
    failed,
    in_progress,
    pending,
    timed_out,

    pub const json_field_names = .{
        .canceled = "CANCELED",
        .canceling = "CANCELING",
        .completed = "COMPLETED",
        .created = "CREATED",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .pending = "PENDING",
        .timed_out = "TIMED_OUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .canceled => "CANCELED",
            .canceling => "CANCELING",
            .completed => "COMPLETED",
            .created => "CREATED",
            .failed => "FAILED",
            .in_progress => "IN_PROGRESS",
            .pending => "PENDING",
            .timed_out => "TIMED_OUT",
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
