const ResourcePendingMaintenanceActions = @import("resource_pending_maintenance_actions.zig").ResourcePendingMaintenanceActions;

pub const ApplyPendingMaintenanceActionResult = struct {
    resource_pending_maintenance_actions: ?ResourcePendingMaintenanceActions,
};
