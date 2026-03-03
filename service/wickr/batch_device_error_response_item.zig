/// Contains error information for a device operation that failed in a batch
/// device request.
pub const BatchDeviceErrorResponseItem = struct {
    /// The application ID of the device that failed to be processed.
    app_id: []const u8,

    /// The field that caused the error.
    field: ?[]const u8 = null,

    /// A description of why the device operation failed.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_id = "appId",
        .field = "field",
        .reason = "reason",
    };
};
