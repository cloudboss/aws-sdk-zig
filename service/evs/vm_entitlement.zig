const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const EntitlementStatus = @import("entitlement_status.zig").EntitlementStatus;
const EntitlementType = @import("entitlement_type.zig").EntitlementType;

/// An object that represents a Windows Server License entitlement for a virtual
/// machine in an Amazon EVS environment.
pub const VmEntitlement = struct {
    /// The unique ID of the connector associated with the entitlement.
    connector_id: ?[]const u8 = null,

    /// The unique ID of the environment.
    environment_id: ?[]const u8 = null,

    /// The error details associated with the entitlement, if applicable.
    error_detail: ?ErrorDetail = null,

    /// The date and time that the entitlement was last synced.
    last_synced_at: ?i64 = null,

    /// The date and time that the entitlement started.
    started_at: ?i64 = null,

    /// The status of the entitlement.
    status: ?EntitlementStatus = null,

    /// The date and time that the entitlement stopped.
    stopped_at: ?i64 = null,

    /// The type of entitlement.
    @"type": ?EntitlementType = null,

    /// The unique ID of the virtual machine.
    vm_id: ?[]const u8 = null,

    /// The name of the virtual machine.
    vm_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_id = "connectorId",
        .environment_id = "environmentId",
        .error_detail = "errorDetail",
        .last_synced_at = "lastSyncedAt",
        .started_at = "startedAt",
        .status = "status",
        .stopped_at = "stoppedAt",
        .@"type" = "type",
        .vm_id = "vmId",
        .vm_name = "vmName",
    };
};
