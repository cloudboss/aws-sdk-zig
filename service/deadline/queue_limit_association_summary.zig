const QueueLimitAssociationStatus = @import("queue_limit_association_status.zig").QueueLimitAssociationStatus;

/// Provides information about the association between a queue and a limit.
pub const QueueLimitAssociationSummary = struct {
    /// The Unix timestamp of the date and time that the association was created.
    created_at: i64,

    /// The user identifier of the person that created the association.
    created_by: []const u8,

    /// The unique identifier of the limit in the association.
    limit_id: []const u8,

    /// The unique identifier of the queue in the association.
    queue_id: []const u8,

    /// The status of task scheduling in the queue-limit association.
    ///
    /// * `ACTIVE` - Association is active.
    /// * `STOP_LIMIT_USAGE_AND_COMPLETE_TASKS` - Association has stopped scheduling
    ///   new tasks and is completing current tasks.
    /// * `STOP_LIMIT_USAGE_AND_CANCEL_TASKS` - Association has stopped scheduling
    ///   new tasks and is canceling current tasks.
    /// * `STOPPED` - Association has been stopped.
    status: QueueLimitAssociationStatus,

    /// The Unix timestamp of the date and time that the association was last
    /// updated.
    updated_at: ?i64,

    /// The user identifier of the person that updated the association.
    updated_by: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .limit_id = "limitId",
        .queue_id = "queueId",
        .status = "status",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
