const FreeTrialInfoErrorCode = @import("free_trial_info_error_code.zig").FreeTrialInfoErrorCode;

/// Information about an error received while accessing free trail data for an
/// account.
pub const FreeTrialInfoError = struct {
    /// The account associated with the Amazon Inspector free trial information.
    account_id: []const u8,

    /// The error code.
    code: FreeTrialInfoErrorCode,

    /// The error message returned.
    message: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .code = "code",
        .message = "message",
    };
};
