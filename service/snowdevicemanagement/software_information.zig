/// Information about the software on the device.
pub const SoftwareInformation = struct {
    /// The version of the software currently installed on the device.
    installed_version: ?[]const u8,

    /// The version of the software being installed on the device.
    installing_version: ?[]const u8,

    /// The state of the software that is installed or that is being installed on
    /// the
    /// device.
    install_state: ?[]const u8,

    pub const json_field_names = .{
        .installed_version = "installedVersion",
        .installing_version = "installingVersion",
        .install_state = "installState",
    };
};
