const QueueFleetAssociationStatus = @import("queue_fleet_association_status.zig").QueueFleetAssociationStatus;

/// The details of a queue-fleet association.
pub const QueueFleetAssociationSummary = struct {
    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.
    created_by: []const u8,

    /// The fleet ID.
    fleet_id: []const u8,

    /// The queue ID.
    queue_id: []const u8,

    /// The status of task scheduling in the queue-fleet association.
    ///
    /// * `ACTIVE`–Association is active.
    /// * `STOP_SCHEDULING_AND_COMPLETE_TASKS`–Association has stopped scheduling
    ///   new tasks and is completing current tasks.
    /// * `STOP_SCHEDULING_AND_CANCEL_TASKS`–Association has stopped scheduling new
    ///   tasks and is canceling current tasks.
    /// * `STOPPED`–Association has been stopped.
    status: QueueFleetAssociationStatus,

    /// The date and time the resource was updated.
    updated_at: ?i64,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .fleet_id = "fleetId",
        .queue_id = "queueId",
        .status = "status",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
