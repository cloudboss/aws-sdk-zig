const ErrorCode = @import("error_code.zig").ErrorCode;

/// Provides information about a Amazon Q Business request error.
pub const ErrorDetail = struct {
    /// The code associated with the Amazon Q Business request error.
    error_code: ?ErrorCode,

    /// The message explaining the Amazon Q Business request error.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
