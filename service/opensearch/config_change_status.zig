const std = @import("std");

pub const ConfigChangeStatus = enum {
    pending,
    initializing,
    validating,
    validation_failed,
    applying_changes,
    completed,
    pending_user_input,
    cancelled,

    pub const json_field_names = .{
        .pending = "Pending",
        .initializing = "Initializing",
        .validating = "Validating",
        .validation_failed = "ValidationFailed",
        .applying_changes = "ApplyingChanges",
        .completed = "Completed",
        .pending_user_input = "PendingUserInput",
        .cancelled = "Cancelled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .initializing => "Initializing",
            .validating => "Validating",
            .validation_failed => "ValidationFailed",
            .applying_changes => "ApplyingChanges",
            .completed => "Completed",
            .pending_user_input => "PendingUserInput",
            .cancelled => "Cancelled",
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
