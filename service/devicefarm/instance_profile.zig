/// Represents the instance profile.
pub const InstanceProfile = struct {
    /// The Amazon Resource Name (ARN) of the instance profile.
    arn: ?[]const u8 = null,

    /// The description of the instance profile.
    description: ?[]const u8 = null,

    /// An array of strings containing the list of app packages that should not be
    /// cleaned up from the device
    /// after a test run completes.
    ///
    /// The list of packages is considered only if you set `packageCleanup` to
    /// `true`.
    exclude_app_packages_from_cleanup: ?[]const []const u8 = null,

    /// The name of the instance profile.
    name: ?[]const u8 = null,

    /// When set to `true`, Device Farm removes app packages after a test run. The
    /// default value is
    /// `false` for private devices.
    package_cleanup: ?bool = null,

    /// When set to `true`, Device Farm reboots the instance after a test run. The
    /// default value is
    /// `true`.
    reboot_after_use: ?bool = null,

    pub const json_field_names = .{
        .arn = "arn",
        .description = "description",
        .exclude_app_packages_from_cleanup = "excludeAppPackagesFromCleanup",
        .name = "name",
        .package_cleanup = "packageCleanup",
        .reboot_after_use = "rebootAfterUse",
    };
};
