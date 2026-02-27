const ErrorCode = @import("error_code.zig").ErrorCode;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;
const Status = @import("status.zig").Status;

/// An object with details on why an account failed to enable Amazon Inspector.
pub const FailedAccount = struct {
    /// The Amazon Web Services account ID.
    account_id: []const u8,

    /// The error code explaining why the account failed to enable Amazon Inspector.
    error_code: ErrorCode,

    /// The error message received when the account failed to enable Amazon
    /// Inspector.
    error_message: []const u8,

    /// An object detailing which resources Amazon Inspector is enabled to scan for
    /// the account.
    resource_status: ?ResourceStatus,

    /// The status of Amazon Inspector for the account.
    status: ?Status,

    pub const json_field_names = .{
        .account_id = "accountId",
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .resource_status = "resourceStatus",
        .status = "status",
    };
};
