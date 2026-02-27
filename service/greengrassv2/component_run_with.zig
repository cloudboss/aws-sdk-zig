const SystemResourceLimits = @import("system_resource_limits.zig").SystemResourceLimits;

/// Contains information system user and group that the IoT Greengrass Core
/// software uses to run component
/// processes on the core device. For more information, see [Configure the user
/// and group that run
/// components](https://docs.aws.amazon.com/greengrass/v2/developerguide/configure-greengrass-core-v2.html#configure-component-user) in the *IoT Greengrass V2 Developer
/// Guide*.
pub const ComponentRunWith = struct {
    /// The POSIX system user and, optionally, group to use to run this component on
    /// Linux core
    /// devices. The user, and group if specified, must exist on each Linux core
    /// device. Specify the
    /// user and group separated by a colon (`:`) in the following format:
    /// `user:group`. The group is optional. If you don't specify a group, the IoT
    /// Greengrass Core
    /// software uses the primary user for the group.
    ///
    /// If you omit this parameter, the IoT Greengrass Core software uses the
    /// default system user and group that
    /// you configure on the Greengrass nucleus component. For more information, see
    /// [Configure the user and group that run
    /// components](https://docs.aws.amazon.com/greengrass/v2/developerguide/configure-greengrass-core-v2.html#configure-component-user).
    posix_user: ?[]const u8,

    /// The system resource limits to apply to this component's process on the core
    /// device. IoT Greengrass
    /// currently supports this feature on only Linux core devices.
    ///
    /// If you omit this parameter, the IoT Greengrass Core software uses the
    /// default system resource limits
    /// that you configure on the Greengrass nucleus component. For more
    /// information, see [Configure system resource limits for
    /// components](https://docs.aws.amazon.com/greengrass/v2/developerguide/configure-greengrass-core-v2.html#configure-component-system-resource-limits).
    system_resource_limits: ?SystemResourceLimits,

    /// The Windows user to use to run this component on Windows core devices. The
    /// user must exist
    /// on each Windows core device, and its name and password must be in the
    /// LocalSystem account's
    /// Credentials Manager instance.
    ///
    /// If you omit this parameter, the IoT Greengrass Core software uses the
    /// default Windows user that you
    /// configure on the Greengrass nucleus component. For more information, see
    /// [Configure the user and group that run
    /// components](https://docs.aws.amazon.com/greengrass/v2/developerguide/configure-greengrass-core-v2.html#configure-component-user).
    windows_user: ?[]const u8,

    pub const json_field_names = .{
        .posix_user = "posixUser",
        .system_resource_limits = "systemResourceLimits",
        .windows_user = "windowsUser",
    };
};
