pub const InsightType = enum {
    api_call_rate_insight,
    api_error_rate_insight,

    pub const json_field_names = .{
        .api_call_rate_insight = "ApiCallRateInsight",
        .api_error_rate_insight = "ApiErrorRateInsight",
    };
};
