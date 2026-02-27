pub const HealthStatusReason = enum {
    billing_view_no_access,
    billing_view_unhealthy,
    filter_invalid,
    multi_year_historical_data_disabled,

    pub const json_field_names = .{
        .billing_view_no_access = "BILLING_VIEW_NO_ACCESS",
        .billing_view_unhealthy = "BILLING_VIEW_UNHEALTHY",
        .filter_invalid = "FILTER_INVALID",
        .multi_year_historical_data_disabled = "MULTI_YEAR_HISTORICAL_DATA_DISABLED",
    };
};
