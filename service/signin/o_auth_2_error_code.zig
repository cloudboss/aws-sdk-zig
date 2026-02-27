/// OAuth 2.0 error codes returned by the server
///
/// Standard OAuth 2.0 error codes used in error responses to indicate
/// the specific type of error that occurred during token operations.
pub const OAuth2ErrorCode = enum {
    /// Token has expired and needs to be refreshed
    token_expired,
    /// User credentials have been changed
    user_credentials_changed,
    /// Insufficient permissions to perform this operation
    insufficient_permissions,
    /// Authorization code has expired
    authcode_expired,
    /// Internal server error occurred
    server_error,
    /// The request is missing a required parameter, includes an invalid parameter
    /// value, or is otherwise malformed
    invalid_request,

    pub const json_field_names = .{
        .token_expired = "TOKEN_EXPIRED",
        .user_credentials_changed = "USER_CREDENTIALS_CHANGED",
        .insufficient_permissions = "INSUFFICIENT_PERMISSIONS",
        .authcode_expired = "AUTHCODE_EXPIRED",
        .server_error = "SERVER_ERROR",
        .invalid_request = "INVALID_REQUEST",
    };
};
