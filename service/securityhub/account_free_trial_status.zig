const FreeTrialStatus = @import("free_trial_status.zig").FreeTrialStatus;

/// The free trial status of each Security Hub feature for an account.
pub const AccountFreeTrialStatus = struct {
    /// The Amazon Web Services account identifier that the free trial statuses
    /// apply to.
    account_id: []const u8,

    /// The date and time at which Security Hub evaluated the free trial statuses
    /// for this account. Every status in `FreeTrialStatuses` reflects this point in
    /// time.
    evaluated_at: i64,

    /// An array of free trial statuses, one for each feature that has a free trial
    /// period for the account. The array is empty if the account has no free trial
    /// to report.
    free_trial_statuses: []const FreeTrialStatus,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .evaluated_at = "EvaluatedAt",
        .free_trial_statuses = "FreeTrialStatuses",
    };
};
