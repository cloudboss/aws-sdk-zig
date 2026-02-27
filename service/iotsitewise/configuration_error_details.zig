const ErrorCode = @import("error_code.zig").ErrorCode;

/// Contains the details of an IoT SiteWise configuration error.
pub const ConfigurationErrorDetails = struct {
    /// The error code.
    code: ErrorCode,

    /// The error message.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
