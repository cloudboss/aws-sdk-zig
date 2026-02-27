const Ec2DeepInspectionStatus = @import("ec_2_deep_inspection_status.zig").Ec2DeepInspectionStatus;

/// An object that contains details about the state of Amazon Inspector deep
/// inspection for a member
/// account.
pub const MemberAccountEc2DeepInspectionStatusState = struct {
    /// The unique identifier for the Amazon Web Services account of the
    /// organization member
    account_id: []const u8,

    /// The error message explaining why the account failed to activate Amazon
    /// Inspector deep
    /// inspection.
    error_message: ?[]const u8,

    /// The state of Amazon Inspector deep inspection in the member account.
    status: ?Ec2DeepInspectionStatus,

    pub const json_field_names = .{
        .account_id = "accountId",
        .error_message = "errorMessage",
        .status = "status",
    };
};
