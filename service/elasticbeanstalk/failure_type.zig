const std = @import("std");

pub const FailureType = enum {
    update_cancelled,
    cancellation_failed,
    rollback_failed,
    rollback_successful,
    internal_failure,
    invalid_environment_state,
    permissions_error,

    pub const json_field_names = .{
        .update_cancelled = "UpdateCancelled",
        .cancellation_failed = "CancellationFailed",
        .rollback_failed = "RollbackFailed",
        .rollback_successful = "RollbackSuccessful",
        .internal_failure = "InternalFailure",
        .invalid_environment_state = "InvalidEnvironmentState",
        .permissions_error = "PermissionsError",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .update_cancelled => "UpdateCancelled",
            .cancellation_failed => "CancellationFailed",
            .rollback_failed => "RollbackFailed",
            .rollback_successful => "RollbackSuccessful",
            .internal_failure => "InternalFailure",
            .invalid_environment_state => "InvalidEnvironmentState",
            .permissions_error => "PermissionsError",
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
