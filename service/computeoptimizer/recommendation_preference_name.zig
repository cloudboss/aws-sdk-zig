const std = @import("std");

pub const RecommendationPreferenceName = enum {
    enhanced_infrastructure_metrics,
    inferred_workload_types,
    external_metrics_preference,
    lookback_period_preference,
    preferred_resources,
    utilization_preferences,

    pub const json_field_names = .{
        .enhanced_infrastructure_metrics = "EnhancedInfrastructureMetrics",
        .inferred_workload_types = "InferredWorkloadTypes",
        .external_metrics_preference = "ExternalMetricsPreference",
        .lookback_period_preference = "LookBackPeriodPreference",
        .preferred_resources = "PreferredResources",
        .utilization_preferences = "UtilizationPreferences",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enhanced_infrastructure_metrics => "EnhancedInfrastructureMetrics",
            .inferred_workload_types => "InferredWorkloadTypes",
            .external_metrics_preference => "ExternalMetricsPreference",
            .lookback_period_preference => "LookBackPeriodPreference",
            .preferred_resources => "PreferredResources",
            .utilization_preferences => "UtilizationPreferences",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
