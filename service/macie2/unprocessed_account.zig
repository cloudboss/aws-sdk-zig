const ErrorCode = @import("error_code.zig").ErrorCode;

/// Provides information about an account-related request that hasn't been
/// processed.
pub const UnprocessedAccount = struct {
    /// The Amazon Web Services account ID for the account that the request applies
    /// to.
    account_id: ?[]const u8,

    /// The source of the issue or delay in processing the request.
    error_code: ?ErrorCode,

    /// The reason why the request hasn't been processed.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
