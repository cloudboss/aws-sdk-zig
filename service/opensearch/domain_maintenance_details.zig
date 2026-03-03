const MaintenanceType = @import("maintenance_type.zig").MaintenanceType;
const MaintenanceStatus = @import("maintenance_status.zig").MaintenanceStatus;

/// Container for the domain maintenance details.
pub const DomainMaintenanceDetails = struct {
    /// The name of the action.
    action: ?MaintenanceType = null,

    /// The time at which the action was created.
    created_at: ?i64 = null,

    /// The name of the domain.
    domain_name: ?[]const u8 = null,

    /// The ID of the requested action.
    maintenance_id: ?[]const u8 = null,

    /// The ID of the data node.
    node_id: ?[]const u8 = null,

    /// The status of the action.
    status: ?MaintenanceStatus = null,

    /// The status message for the action.
    status_message: ?[]const u8 = null,

    /// The time at which the action was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .action = "Action",
        .created_at = "CreatedAt",
        .domain_name = "DomainName",
        .maintenance_id = "MaintenanceId",
        .node_id = "NodeId",
        .status = "Status",
        .status_message = "StatusMessage",
        .updated_at = "UpdatedAt",
    };
};
