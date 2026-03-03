/// Represents the remote endpoints for viewing and controlling a device during
/// a remote access session.
pub const RemoteAccessEndpoints = struct {
    /// URL for viewing and interacting with the device during the remote access
    /// session.
    interactive_endpoint: ?[]const u8 = null,

    /// URL for controlling the device using WebDriver-compliant clients, like
    /// Appium, during the remote access session.
    remote_driver_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .interactive_endpoint = "interactiveEndpoint",
        .remote_driver_endpoint = "remoteDriverEndpoint",
    };
};
