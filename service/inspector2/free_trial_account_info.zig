const FreeTrialInfo = @import("free_trial_info.zig").FreeTrialInfo;

/// Information about the Amazon Inspector free trial for an account.
pub const FreeTrialAccountInfo = struct {
    /// The account associated with the Amazon Inspector free trial information.
    account_id: []const u8,

    /// Contains information about the Amazon Inspector free trial for an account.
    free_trial_info: []const FreeTrialInfo,

    pub const json_field_names = .{
        .account_id = "accountId",
        .free_trial_info = "freeTrialInfo",
    };
};
