const BrowserActionStatus = @import("browser_action_status.zig").BrowserActionStatus;

/// The result of a screenshot action.
pub const ScreenshotResult = struct {
    /// The base64-encoded image data. Present only when the action succeeded.
    data: ?[]const u8 = null,

    /// The error message. Present only when the action failed.
    @"error": ?[]const u8 = null,

    /// The status of the action execution.
    status: BrowserActionStatus,

    pub const json_field_names = .{
        .data = "data",
        .@"error" = "error",
        .status = "status",
    };
};
