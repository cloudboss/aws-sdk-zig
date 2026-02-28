const FailureType = @import("failure_type.zig").FailureType;

/// Represents information about failure details.
pub const FailureDetails = struct {
    /// The external ID of the run of the action that failed.
    external_execution_id: ?[]const u8,

    /// The message about the failure.
    message: []const u8,

    /// The type of the failure.
    type: FailureType,

    pub const json_field_names = .{
        .external_execution_id = "externalExecutionId",
        .message = "message",
        .type = "type",
    };
};
