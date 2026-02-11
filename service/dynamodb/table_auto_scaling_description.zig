const ReplicaAutoScalingDescription = @import("replica_auto_scaling_description.zig").ReplicaAutoScalingDescription;
const TableStatus = @import("table_status.zig").TableStatus;

/// Represents the auto scaling configuration for a global table.
pub const TableAutoScalingDescription = struct {
    /// Represents replicas of the global table.
    replicas: ?[]const ReplicaAutoScalingDescription,

    /// The name of the table.
    table_name: ?[]const u8,

    /// The current state of the table:
    ///
    /// * `CREATING` - The table is being created.
    ///
    /// * `UPDATING` - The table is being updated.
    ///
    /// * `DELETING` - The table is being deleted.
    ///
    /// * `ACTIVE` - The table is ready for use.
    table_status: ?TableStatus,

    pub const json_field_names = .{
        .replicas = "Replicas",
        .table_name = "TableName",
        .table_status = "TableStatus",
    };
};
