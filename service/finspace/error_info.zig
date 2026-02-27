const ErrorDetails = @import("error_details.zig").ErrorDetails;

/// Provides details in the event of a failed flow, including the error type and
/// the related error message.
pub const ErrorInfo = struct {
    /// Specifies the error message that appears if a flow fails.
    error_message: ?[]const u8,

    /// Specifies the type of error.
    error_type: ?ErrorDetails,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .error_type = "errorType",
    };
};
