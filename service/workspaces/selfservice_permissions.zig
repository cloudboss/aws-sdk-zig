const ReconnectEnum = @import("reconnect_enum.zig").ReconnectEnum;

/// Describes the self-service permissions for a directory. For more
/// information, see [Enable Self-Service WorkSpace Management Capabilities for
/// Your
/// Users](https://docs.aws.amazon.com/workspaces/latest/adminguide/enable-user-self-service-workspace-management.html).
pub const SelfservicePermissions = struct {
    /// Specifies whether users can change the compute type (bundle) for their
    /// WorkSpace.
    change_compute_type: ?ReconnectEnum,

    /// Specifies whether users can increase the volume size of the drives on their
    /// WorkSpace.
    increase_volume_size: ?ReconnectEnum,

    /// Specifies whether users can rebuild the operating system of a WorkSpace to
    /// its original
    /// state.
    rebuild_workspace: ?ReconnectEnum,

    /// Specifies whether users can restart their WorkSpace.
    restart_workspace: ?ReconnectEnum,

    /// Specifies whether users can switch the running mode of their WorkSpace.
    switch_running_mode: ?ReconnectEnum,

    pub const json_field_names = .{
        .change_compute_type = "ChangeComputeType",
        .increase_volume_size = "IncreaseVolumeSize",
        .rebuild_workspace = "RebuildWorkspace",
        .restart_workspace = "RestartWorkspace",
        .switch_running_mode = "SwitchRunningMode",
    };
};
