/// Contains information about which data sources are enabled for the GuardDuty
/// member
/// account.
pub const DataSourceFreeTrial = struct {
    /// A value that specifies the number of days left to use each enabled data
    /// source.
    free_trial_days_remaining: ?i32 = null,

    pub const json_field_names = .{
        .free_trial_days_remaining = "FreeTrialDaysRemaining",
    };
};
