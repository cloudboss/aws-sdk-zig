const std = @import("std");

pub const InstanceRefreshStatus = enum {
    pending,
    in_progress,
    successful,
    failed,
    cancelling,
    cancelled,
    rollback_in_progress,
    rollback_failed,
    rollback_successful,
    baking,

    pub const json_field_names = .{
        .pending = "Pending",
        .in_progress = "InProgress",
        .successful = "Successful",
        .failed = "Failed",
        .cancelling = "Cancelling",
        .cancelled = "Cancelled",
        .rollback_in_progress = "RollbackInProgress",
        .rollback_failed = "RollbackFailed",
        .rollback_successful = "RollbackSuccessful",
        .baking = "Baking",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .in_progress => "InProgress",
            .successful => "Successful",
            .failed => "Failed",
            .cancelling => "Cancelling",
            .cancelled => "Cancelled",
            .rollback_in_progress => "RollbackInProgress",
            .rollback_failed => "RollbackFailed",
            .rollback_successful => "RollbackSuccessful",
            .baking => "Baking",
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
