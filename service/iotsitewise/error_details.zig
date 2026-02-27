const ErrorCode = @import("error_code.zig").ErrorCode;
const DetailedError = @import("detailed_error.zig").DetailedError;

/// Contains the details of an IoT SiteWise error.
pub const ErrorDetails = struct {
    /// The error code.
    code: ErrorCode,

    /// A list of detailed errors.
    details: ?[]const DetailedError,

    /// The error message.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .details = "details",
        .message = "message",
    };
};
