const PendingMaintenanceAction = @import("pending_maintenance_action.zig").PendingMaintenanceAction;

/// Identifies an DMS resource and any pending actions for it.
pub const ResourcePendingMaintenanceActions = struct {
    /// Detailed information about the pending maintenance action.
    pending_maintenance_action_details: ?[]const PendingMaintenanceAction = null,

    /// The Amazon Resource Name (ARN) of the DMS resource that the pending
    /// maintenance action
    /// applies to. For information about creating an ARN, see [ Constructing an
    /// Amazon
    /// Resource Name (ARN) for
    /// DMS](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Introduction.AWS.ARN.html) in the DMS documentation.
    resource_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .pending_maintenance_action_details = "PendingMaintenanceActionDetails",
        .resource_identifier = "ResourceIdentifier",
    };
};
