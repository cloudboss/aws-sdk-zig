/// Contains information about a device that was successfully processed in a
/// batch device operation.
pub const BatchDeviceSuccessResponseItem = struct {
    /// The application ID of the device that was successfully processed.
    app_id: []const u8,

    pub const json_field_names = .{
        .app_id = "appId",
    };
};
