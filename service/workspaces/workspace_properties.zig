const Compute = @import("compute.zig").Compute;
const GlobalAcceleratorForWorkSpace = @import("global_accelerator_for_work_space.zig").GlobalAcceleratorForWorkSpace;
const OperatingSystemName = @import("operating_system_name.zig").OperatingSystemName;
const Protocol = @import("protocol.zig").Protocol;
const RunningMode = @import("running_mode.zig").RunningMode;

/// Describes a WorkSpace.
pub const WorkspaceProperties = struct {
    /// The compute type. For more information, see [Amazon WorkSpaces
    /// Bundles](http://aws.amazon.com/workspaces/details/#Amazon_WorkSpaces_Bundles).
    compute_type_name: ?Compute,

    /// Indicates the Global Accelerator properties.
    global_accelerator: ?GlobalAcceleratorForWorkSpace,

    /// The name of the operating system.
    operating_system_name: ?OperatingSystemName,

    /// The protocol. For more information, see
    /// [
    /// Protocols for Amazon
    /// WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/amazon-workspaces-protocols.html).
    ///
    /// * Only available for WorkSpaces created with PCoIP bundles.
    ///
    /// * The `Protocols` property is case sensitive. Ensure you use `PCOIP` or
    ///   `DCV` (formerly WSP).
    ///
    /// * Unavailable for Windows 7 WorkSpaces and WorkSpaces using GPU-based
    ///   bundles
    /// (Graphics, GraphicsPro, Graphics.g4dn, and GraphicsPro.g4dn).
    protocols: ?[]const Protocol,

    /// The size of the root volume. For important information about how to modify
    /// the size of
    /// the root and user volumes, see [Modify a
    /// WorkSpace](https://docs.aws.amazon.com/workspaces/latest/adminguide/modify-workspaces.html).
    root_volume_size_gib: ?i32,

    /// The running mode. For more information, see [Manage the WorkSpace Running
    /// Mode](https://docs.aws.amazon.com/workspaces/latest/adminguide/running-mode.html).
    ///
    /// The `MANUAL` value is only supported by Amazon WorkSpaces Core. Contact
    /// your account team to be allow-listed to use this value. For more
    /// information, see
    /// [Amazon WorkSpaces Core](http://aws.amazon.com/workspaces/core/).
    ///
    /// Review your running mode to ensure you are using one that is optimal for
    /// your needs and
    /// budget. For more information on switching running modes, see [ Can I switch
    /// between hourly and monthly
    /// billing?](http://aws.amazon.com/workspaces-family/workspaces/faqs/#:~:text=Can%20I%20switch%20between%20hourly%20and%20monthly%20billing%20on%20WorkSpaces%20Personal%3F)
    running_mode: ?RunningMode,

    /// The time after a user logs off when WorkSpaces are automatically stopped.
    /// Configured in
    /// 60-minute intervals.
    running_mode_auto_stop_timeout_in_minutes: ?i32,

    /// The size of the user storage. For important information about how to modify
    /// the size of
    /// the root and user volumes, see [Modify a
    /// WorkSpace](https://docs.aws.amazon.com/workspaces/latest/adminguide/modify-workspaces.html).
    user_volume_size_gib: ?i32,

    pub const json_field_names = .{
        .compute_type_name = "ComputeTypeName",
        .global_accelerator = "GlobalAccelerator",
        .operating_system_name = "OperatingSystemName",
        .protocols = "Protocols",
        .root_volume_size_gib = "RootVolumeSizeGib",
        .running_mode = "RunningMode",
        .running_mode_auto_stop_timeout_in_minutes = "RunningModeAutoStopTimeoutInMinutes",
        .user_volume_size_gib = "UserVolumeSizeGib",
    };
};
