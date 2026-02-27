pub const RecommendationPreferenceName = enum {
    enhanced_infrastructure_metrics,
    inferred_workload_types,
    external_metrics_preference,
    lookback_period_preference,
    preferred_resources,
    utilization_preferences,

    pub const json_field_names = .{
        .enhanced_infrastructure_metrics = "ENHANCED_INFRASTRUCTURE_METRICS",
        .inferred_workload_types = "INFERRED_WORKLOAD_TYPES",
        .external_metrics_preference = "EXTERNAL_METRICS_PREFERENCE",
        .lookback_period_preference = "LOOKBACK_PERIOD_PREFERENCE",
        .preferred_resources = "PREFERRED_RESOURCES",
        .utilization_preferences = "UTILIZATION_PREFERENCES",
    };
};
