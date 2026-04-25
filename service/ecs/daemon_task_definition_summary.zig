const DaemonTaskDefinitionStatus = @import("daemon_task_definition_status.zig").DaemonTaskDefinitionStatus;

/// A summary of a daemon task definition.
pub const DaemonTaskDefinitionSummary = struct {
    /// The Amazon Resource Name (ARN) of the daemon task definition.
    arn: ?[]const u8 = null,

    /// The Unix timestamp for the time when the daemon task definition delete was
    /// requested.
    delete_requested_at: ?i64 = null,

    /// The Unix timestamp for the time when the daemon task definition was
    /// registered.
    registered_at: ?i64 = null,

    /// The principal that registered the daemon task definition.
    registered_by: ?[]const u8 = null,

    /// The status of the daemon task definition.
    status: ?DaemonTaskDefinitionStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .delete_requested_at = "deleteRequestedAt",
        .registered_at = "registeredAt",
        .registered_by = "registeredBy",
        .status = "status",
    };
};
