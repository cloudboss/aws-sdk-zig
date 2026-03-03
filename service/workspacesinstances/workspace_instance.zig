const EC2ManagedInstance = @import("ec2_managed_instance.zig").EC2ManagedInstance;
const ProvisionStateEnum = @import("provision_state_enum.zig").ProvisionStateEnum;

/// Represents a single WorkSpace Instance.
pub const WorkspaceInstance = struct {
    /// Details of the associated EC2 managed instance.
    ec2_managed_instance: ?EC2ManagedInstance = null,

    /// Current provisioning state of the WorkSpace Instance.
    provision_state: ?ProvisionStateEnum = null,

    /// Unique identifier for the WorkSpace Instance.
    workspace_instance_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ec2_managed_instance = "EC2ManagedInstance",
        .provision_state = "ProvisionState",
        .workspace_instance_id = "WorkspaceInstanceId",
    };
};
