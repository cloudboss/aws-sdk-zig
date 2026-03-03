/// Represents a device where a user has logged into Wickr, containing
/// information about the device's type, status, and login history.
pub const BasicDeviceObject = struct {
    /// The unique application ID for the Wickr app on this device.
    app_id: ?[]const u8 = null,

    /// The timestamp when the device first appeared in the Wickr database.
    created: ?[]const u8 = null,

    /// The timestamp when the device last successfully logged into Wickr. This is
    /// also used to determine SSO idle time.
    last_login: ?[]const u8 = null,

    /// The current status of the device, either 'Active' or 'Reset' depending on
    /// whether the device is currently active or has been marked for reset.
    status_text: ?[]const u8 = null,

    /// Indicates whether the device is suspended.
    @"suspend": ?bool = null,

    /// The operating system of the device (e.g., 'MacOSX', 'Windows', 'iOS',
    /// 'Android').
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .app_id = "appId",
        .created = "created",
        .last_login = "lastLogin",
        .status_text = "statusText",
        .@"suspend" = "suspend",
        .@"type" = "type",
    };
};
