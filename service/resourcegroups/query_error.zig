const QueryErrorCode = @import("query_error_code.zig").QueryErrorCode;

/// A two-part error structure that can occur in `ListGroupResources` or
/// `SearchResources`.
pub const QueryError = struct {
    /// Specifies the error code that was raised.
    error_code: ?QueryErrorCode,

    /// A message that explains the `ErrorCode`.
    message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
    };
};
