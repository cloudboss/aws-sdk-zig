const PrivateConnectionProvisioningFailureCause = @import("private_connection_provisioning_failure_cause.zig").PrivateConnectionProvisioningFailureCause;
const PrivateConnectionProvisioningStatus = @import("private_connection_provisioning_status.zig").PrivateConnectionProvisioningStatus;

/// Specifies the private connection provisioning state.
pub const PrivateConnectionProvisioningState = struct {
    /// Specifies the private connection provisioning failure cause.
    failure_cause: ?PrivateConnectionProvisioningFailureCause,

    /// Specifies the private connection provisioning failure reason.
    failure_message: ?[]const u8,

    /// Specifies the private connection provisioning status.
    status: ?PrivateConnectionProvisioningStatus,

    pub const json_field_names = .{
        .failure_cause = "failureCause",
        .failure_message = "failureMessage",
        .status = "status",
    };
};
