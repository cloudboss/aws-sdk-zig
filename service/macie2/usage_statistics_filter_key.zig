/// The field to use in a condition that filters the results of a query for
/// Amazon Macie account quotas and usage data. Valid values are:
pub const UsageStatisticsFilterKey = enum {
    account_id,
    service_limit,
    free_trial_start_date,
    total,

    pub const json_field_names = .{
        .account_id = "accountId",
        .service_limit = "serviceLimit",
        .free_trial_start_date = "freeTrialStartDate",
        .total = "total",
    };
};
