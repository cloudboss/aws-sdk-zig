const BrowserActionStatus = @import("browser_action_status.zig").BrowserActionStatus;

/// The result of a key type action.
pub const KeyTypeResult = struct {
    /// The error message. Present only when the action failed.
    @"error": ?[]const u8 = null,

    /// The status of the action execution.
    status: BrowserActionStatus,

    pub const json_field_names = .{
        .@"error" = "error",
        .status = "status",
    };
};
