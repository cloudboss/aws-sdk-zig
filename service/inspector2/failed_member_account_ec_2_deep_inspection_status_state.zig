const Status = @import("status.zig").Status;

/// An object that contains details about a member account in your organization
/// that failed
/// to activate Amazon Inspector deep inspection.
pub const FailedMemberAccountEc2DeepInspectionStatusState = struct {
    /// The unique identifier for the Amazon Web Services account of the
    /// organization member that failed to
    /// activate Amazon Inspector deep inspection.
    account_id: []const u8,

    /// The status of EC2 scanning in the account that failed to activate Amazon
    /// Inspector deep
    /// inspection.
    ec_2_scan_status: ?Status = null,

    /// The error message explaining why the account failed to activate Amazon
    /// Inspector deep
    /// inspection.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .ec_2_scan_status = "ec2ScanStatus",
        .error_message = "errorMessage",
    };
};
