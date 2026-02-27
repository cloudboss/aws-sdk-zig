const OrganizationRuleStatus = @import("organization_rule_status.zig").OrganizationRuleStatus;

/// Returns the status for an organization Config rule in an organization.
pub const OrganizationConfigRuleStatus = struct {
    /// An error code that is returned when organization Config rule creation or
    /// deletion has failed.
    error_code: ?[]const u8,

    /// An error message indicating that organization Config rule creation or
    /// deletion failed due to an error.
    error_message: ?[]const u8,

    /// The timestamp of the last update.
    last_update_time: ?i64,

    /// The name that you assign to organization Config rule.
    organization_config_rule_name: []const u8,

    /// Indicates deployment status of an organization Config rule.
    /// When management account calls PutOrganizationConfigRule action for the first
    /// time, Config rule status is created in all the member accounts.
    /// When management account calls PutOrganizationConfigRule action for the
    /// second time, Config rule status is updated in all the member accounts.
    /// Additionally, Config rule status is updated when one or more member accounts
    /// join or leave an organization.
    /// Config rule status is deleted when the management account deletes
    /// OrganizationConfigRule in all the member accounts and disables service
    /// access for `config-multiaccountsetup.amazonaws.com`.
    ///
    /// Config sets the state of the rule to:
    ///
    /// * `CREATE_SUCCESSFUL` when an organization Config rule has been successfully
    ///   created in all the member accounts.
    ///
    /// * `CREATE_IN_PROGRESS` when an organization Config rule creation is in
    ///   progress.
    ///
    /// * `CREATE_FAILED` when an organization Config rule creation failed in one or
    ///   more member accounts within that organization.
    ///
    /// * `DELETE_FAILED` when an organization Config rule deletion failed in one or
    ///   more member accounts within that organization.
    ///
    /// * `DELETE_IN_PROGRESS` when an organization Config rule deletion is in
    ///   progress.
    ///
    /// * `DELETE_SUCCESSFUL` when an organization Config rule has been successfully
    ///   deleted from all the member accounts.
    ///
    /// * `UPDATE_SUCCESSFUL` when an organization Config rule has been successfully
    ///   updated in all the member accounts.
    ///
    /// * `UPDATE_IN_PROGRESS` when an organization Config rule update is in
    ///   progress.
    ///
    /// * `UPDATE_FAILED` when an organization Config rule update failed in one or
    ///   more member accounts within that organization.
    organization_rule_status: OrganizationRuleStatus,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .last_update_time = "LastUpdateTime",
        .organization_config_rule_name = "OrganizationConfigRuleName",
        .organization_rule_status = "OrganizationRuleStatus",
    };
};
