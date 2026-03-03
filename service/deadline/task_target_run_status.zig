const std = @import("std");

pub const TaskTargetRunStatus = enum {
    ready,
    failed,
    succeeded,
    canceled,
    suspended,
    pending,

    pub const json_field_names = .{
        .ready = "READY",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .canceled = "CANCELED",
        .suspended = "SUSPENDED",
        .pending = "PENDING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ready => "READY",
            .failed => "FAILED",
            .succeeded => "SUCCEEDED",
            .canceled => "CANCELED",
            .suspended => "SUSPENDED",
            .pending => "PENDING",
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
