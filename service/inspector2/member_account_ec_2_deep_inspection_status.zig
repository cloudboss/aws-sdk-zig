/// An object that contains details about the status of Amazon Inspector deep
/// inspection for a member
/// account in your organization.
pub const MemberAccountEc2DeepInspectionStatus = struct {
    /// The unique identifier for the Amazon Web Services account of the
    /// organization member.
    account_id: []const u8,

    /// Whether Amazon Inspector deep inspection is active in the account. If `TRUE`
    /// Amazon Inspector deep
    /// inspection is active, if `FALSE` it is not active.
    activate_deep_inspection: bool,

    pub const json_field_names = .{
        .account_id = "accountId",
        .activate_deep_inspection = "activateDeepInspection",
    };
};
