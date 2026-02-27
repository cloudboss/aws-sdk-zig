const ErrorCode = @import("error_code.zig").ErrorCode;
const Status = @import("status.zig").Status;

/// An object that described the state of Amazon Inspector scans for an account.
pub const State = struct {
    /// The error code explaining why the account failed to enable Amazon Inspector.
    error_code: ErrorCode,

    /// The error message received when the account failed to enable Amazon
    /// Inspector.
    error_message: []const u8,

    /// The status of Amazon Inspector for the account.
    status: Status,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .status = "status",
    };
};
