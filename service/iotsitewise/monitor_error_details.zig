const MonitorErrorCode = @import("monitor_error_code.zig").MonitorErrorCode;

/// Contains IoT SiteWise Monitor error details.
pub const MonitorErrorDetails = struct {
    /// The error code.
    code: ?MonitorErrorCode,

    /// The error message.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
