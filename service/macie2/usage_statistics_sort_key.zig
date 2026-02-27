/// The field to use to sort the results of a query for Amazon Macie account
/// quotas and usage data. Valid values are:
pub const UsageStatisticsSortKey = enum {
    account_id,
    total,
    service_limit_value,
    free_trial_start_date,

    pub const json_field_names = .{
        .account_id = "accountId",
        .total = "total",
        .service_limit_value = "serviceLimitValue",
        .free_trial_start_date = "freeTrialStartDate",
    };
};
