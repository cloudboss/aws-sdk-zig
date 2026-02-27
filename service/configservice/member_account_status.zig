const MemberAccountRuleStatus = @import("member_account_rule_status.zig").MemberAccountRuleStatus;

/// Organization Config rule creation or deletion status in each member account.
/// This includes the name of the rule, the status, error code and error message
/// when the rule creation or deletion failed.
pub const MemberAccountStatus = struct {
    /// The 12-digit account ID of a member account.
    account_id: []const u8,

    /// The name of Config rule deployed in the member account.
    config_rule_name: []const u8,

    /// An error code that is returned when Config rule creation or deletion failed
    /// in the member account.
    error_code: ?[]const u8,

    /// An error message indicating that Config rule account creation or deletion
    /// has failed due to an error in the member account.
    error_message: ?[]const u8,

    /// The timestamp of the last status update.
    last_update_time: ?i64,

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
    member_account_rule_status: MemberAccountRuleStatus,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .config_rule_name = "ConfigRuleName",
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .last_update_time = "LastUpdateTime",
        .member_account_rule_status = "MemberAccountRuleStatus",
    };
};
