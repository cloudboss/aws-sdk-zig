const ResponderErrorMaskingAction = @import("responder_error_masking_action.zig").ResponderErrorMaskingAction;
const ResponderErrorMaskingLoggingType = @import("responder_error_masking_logging_type.zig").ResponderErrorMaskingLoggingType;

/// Describes the masking for HTTP error codes.
pub const ResponderErrorMaskingForHttpCode = struct {
    /// The action for the error..
    action: ResponderErrorMaskingAction,

    /// The HTTP error code.
    http_code: []const u8,

    /// The error log type.
    logging_types: []const ResponderErrorMaskingLoggingType,

    /// The percentage of response logging.
    response_logging_percentage: ?f32,

    pub const json_field_names = .{
        .action = "action",
        .http_code = "httpCode",
        .logging_types = "loggingTypes",
        .response_logging_percentage = "responseLoggingPercentage",
    };
};
