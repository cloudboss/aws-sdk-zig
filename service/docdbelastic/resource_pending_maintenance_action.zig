const PendingMaintenanceActionDetails = @import("pending_maintenance_action_details.zig").PendingMaintenanceActionDetails;

/// Provides information about a pending maintenance action for a resource.
pub const ResourcePendingMaintenanceAction = struct {
    /// Provides information about a pending maintenance action for a resource.
    pending_maintenance_action_details: ?[]const PendingMaintenanceActionDetails = null,

    /// The Amazon DocumentDB Amazon Resource Name (ARN) of the resource to which
    /// the pending maintenance action applies.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .pending_maintenance_action_details = "pendingMaintenanceActionDetails",
        .resource_arn = "resourceArn",
    };
};
