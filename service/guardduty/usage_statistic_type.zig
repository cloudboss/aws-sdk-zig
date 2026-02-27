pub const UsageStatisticType = enum {
    sum_by_account,
    sum_by_data_source,
    sum_by_resource,
    top_resources,
    sum_by_features,
    top_accounts_by_feature,

    pub const json_field_names = .{
        .sum_by_account = "SUM_BY_ACCOUNT",
        .sum_by_data_source = "SUM_BY_DATA_SOURCE",
        .sum_by_resource = "SUM_BY_RESOURCE",
        .top_resources = "TOP_RESOURCES",
        .sum_by_features = "SUM_BY_FEATURES",
        .top_accounts_by_feature = "TOP_ACCOUNTS_BY_FEATURE",
    };
};
