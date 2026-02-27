pub const PolicyType = enum {
    data_protection_policy,
    subscription_filter_policy,
    field_index_policy,
    transformer_policy,
    metric_extraction_policy,

    pub const json_field_names = .{
        .data_protection_policy = "DATA_PROTECTION_POLICY",
        .subscription_filter_policy = "SUBSCRIPTION_FILTER_POLICY",
        .field_index_policy = "FIELD_INDEX_POLICY",
        .transformer_policy = "TRANSFORMER_POLICY",
        .metric_extraction_policy = "METRIC_EXTRACTION_POLICY",
    };
};
