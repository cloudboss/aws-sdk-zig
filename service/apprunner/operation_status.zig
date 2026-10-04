const std = @import("std");

pub const OperationStatus = enum {
    pending,
    in_progress,
    failed,
    succeeded,
    rollback_in_progress,
    rollback_failed,
    rollback_succeeded,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .rollback_in_progress = "ROLLBACK_IN_PROGRESS",
        .rollback_failed = "ROLLBACK_FAILED",
        .rollback_succeeded = "ROLLBACK_SUCCEEDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .in_progress => "IN_PROGRESS",
            .failed => "FAILED",
            .succeeded => "SUCCEEDED",
            .rollback_in_progress => "ROLLBACK_IN_PROGRESS",
            .rollback_failed => "ROLLBACK_FAILED",
            .rollback_succeeded => "ROLLBACK_SUCCEEDED",
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
