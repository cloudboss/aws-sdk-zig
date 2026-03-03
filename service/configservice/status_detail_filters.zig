const MemberAccountRuleStatus = @import("member_account_rule_status.zig").MemberAccountRuleStatus;

/// Status filter object to filter results based on specific member account ID
/// or status type for an organization Config rule.
pub const StatusDetailFilters = struct {
    /// The 12-digit account ID of the member account within an organization.
    account_id: ?[]const u8 = null,

    /// Indicates deployment status for Config rule in the member account.
    /// When management account calls `PutOrganizationConfigRule` action for the
    /// first time, Config rule status is created in the member account.
    /// When management account calls `PutOrganizationConfigRule` action for the
    /// second time, Config rule status is updated in the member account.
    /// Config rule status is deleted when the management account deletes
    /// `OrganizationConfigRule` and disables service access for
    /// `config-multiaccountsetup.amazonaws.com`.
    ///
    /// Config sets the state of the rule to:
    ///
    /// * `CREATE_SUCCESSFUL` when Config rule has been created in the member
    ///   account.
    ///
    /// * `CREATE_IN_PROGRESS` when Config rule is being created in the member
    ///   account.
    ///
    /// * `CREATE_FAILED` when Config rule creation has failed in the member
    ///   account.
    ///
    /// * `DELETE_FAILED` when Config rule deletion has failed in the member
    ///   account.
    ///
    /// * `DELETE_IN_PROGRESS` when Config rule is being deleted in the member
    ///   account.
    ///
    /// * `DELETE_SUCCESSFUL` when Config rule has been deleted in the member
    ///   account.
    ///
    /// * `UPDATE_SUCCESSFUL` when Config rule has been updated in the member
    ///   account.
    ///
    /// * `UPDATE_IN_PROGRESS` when Config rule is being updated in the member
    ///   account.
    ///
    /// * `UPDATE_FAILED` when Config rule deletion has failed in the member
    ///   account.
    member_account_rule_status: ?MemberAccountRuleStatus = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .member_account_rule_status = "MemberAccountRuleStatus",
    };
};
