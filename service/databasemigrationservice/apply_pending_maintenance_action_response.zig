const ResourcePendingMaintenanceActions = @import("resource_pending_maintenance_actions.zig").ResourcePendingMaintenanceActions;

pub const ApplyPendingMaintenanceActionResponse = struct {
    /// The DMS resource that the pending maintenance action will be applied to.
    resource_pending_maintenance_actions: ?ResourcePendingMaintenanceActions,

    pub const json_field_names = .{
        .resource_pending_maintenance_actions = "ResourcePendingMaintenanceActions",
    };
};
