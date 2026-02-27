const PendingMaintenanceAction = @import("pending_maintenance_action.zig").PendingMaintenanceAction;

/// Represents the output of ApplyPendingMaintenanceAction.
pub const ResourcePendingMaintenanceActions = struct {
    /// A list that provides details about the pending maintenance actions
    /// for the resource.
    pending_maintenance_action_details: ?[]const PendingMaintenanceAction,

    /// The Amazon Resource Name (ARN) of the resource that has pending
    /// maintenance actions.
    resource_identifier: ?[]const u8,
};
