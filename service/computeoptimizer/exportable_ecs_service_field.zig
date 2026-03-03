const std = @import("std");

pub const ExportableECSServiceField = enum {
    account_id,
    service_arn,
    lookback_period_in_days,
    last_refresh_timestamp,
    launch_type,
    current_performance_risk,
    current_service_configuration_memory,
    current_service_configuration_cpu,
    current_service_configuration_task_definition_arn,
    current_service_configuration_auto_scaling_configuration,
    current_service_container_configurations,
    utilization_metrics_cpu_maximum,
    utilization_metrics_memory_maximum,
    finding,
    finding_reason_codes,
    recommendation_options_memory,
    recommendation_options_cpu,
    recommendation_options_savings_opportunity_percentage,
    recommendation_options_estimated_monthly_savings_currency,
    recommendation_options_estimated_monthly_savings_value,
    recommendation_options_container_recommendations,
    recommendation_options_projected_utilization_metrics_cpu_maximum,
    recommendation_options_projected_utilization_metrics_memory_maximum,
    tags,
    effective_recommendation_preferences_savings_estimation_mode,
    recommendation_options_savings_opportunity_after_discounts_percentage,
    recommendation_options_estimated_monthly_savings_currency_after_discounts,
    recommendation_options_estimated_monthly_savings_value_after_discounts,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .service_arn = "ServiceArn",
        .lookback_period_in_days = "LookbackPeriodInDays",
        .last_refresh_timestamp = "LastRefreshTimestamp",
        .launch_type = "LaunchType",
        .current_performance_risk = "CurrentPerformanceRisk",
        .current_service_configuration_memory = "CurrentServiceConfigurationMemory",
        .current_service_configuration_cpu = "CurrentServiceConfigurationCpu",
        .current_service_configuration_task_definition_arn = "CurrentServiceConfigurationTaskDefinitionArn",
        .current_service_configuration_auto_scaling_configuration = "CurrentServiceConfigurationAutoScalingConfiguration",
        .current_service_container_configurations = "CurrentServiceContainerConfigurations",
        .utilization_metrics_cpu_maximum = "UtilizationMetricsCpuMaximum",
        .utilization_metrics_memory_maximum = "UtilizationMetricsMemoryMaximum",
        .finding = "Finding",
        .finding_reason_codes = "FindingReasonCodes",
        .recommendation_options_memory = "RecommendationOptionsMemory",
        .recommendation_options_cpu = "RecommendationOptionsCpu",
        .recommendation_options_savings_opportunity_percentage = "RecommendationOptionsSavingsOpportunityPercentage",
        .recommendation_options_estimated_monthly_savings_currency = "RecommendationOptionsEstimatedMonthlySavingsCurrency",
        .recommendation_options_estimated_monthly_savings_value = "RecommendationOptionsEstimatedMonthlySavingsValue",
        .recommendation_options_container_recommendations = "RecommendationOptionsContainerRecommendations",
        .recommendation_options_projected_utilization_metrics_cpu_maximum = "RecommendationOptionsProjectedUtilizationMetricsCpuMaximum",
        .recommendation_options_projected_utilization_metrics_memory_maximum = "RecommendationOptionsProjectedUtilizationMetricsMemoryMaximum",
        .tags = "Tags",
        .effective_recommendation_preferences_savings_estimation_mode = "EffectiveRecommendationPreferencesSavingsEstimationMode",
        .recommendation_options_savings_opportunity_after_discounts_percentage = "RecommendationOptionsSavingsOpportunityAfterDiscountsPercentage",
        .recommendation_options_estimated_monthly_savings_currency_after_discounts = "RecommendationOptionsEstimatedMonthlySavingsCurrencyAfterDiscounts",
        .recommendation_options_estimated_monthly_savings_value_after_discounts = "RecommendationOptionsEstimatedMonthlySavingsValueAfterDiscounts",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_id => "AccountId",
            .service_arn => "ServiceArn",
            .lookback_period_in_days => "LookbackPeriodInDays",
            .last_refresh_timestamp => "LastRefreshTimestamp",
            .launch_type => "LaunchType",
            .current_performance_risk => "CurrentPerformanceRisk",
            .current_service_configuration_memory => "CurrentServiceConfigurationMemory",
            .current_service_configuration_cpu => "CurrentServiceConfigurationCpu",
            .current_service_configuration_task_definition_arn => "CurrentServiceConfigurationTaskDefinitionArn",
            .current_service_configuration_auto_scaling_configuration => "CurrentServiceConfigurationAutoScalingConfiguration",
            .current_service_container_configurations => "CurrentServiceContainerConfigurations",
            .utilization_metrics_cpu_maximum => "UtilizationMetricsCpuMaximum",
            .utilization_metrics_memory_maximum => "UtilizationMetricsMemoryMaximum",
            .finding => "Finding",
            .finding_reason_codes => "FindingReasonCodes",
            .recommendation_options_memory => "RecommendationOptionsMemory",
            .recommendation_options_cpu => "RecommendationOptionsCpu",
            .recommendation_options_savings_opportunity_percentage => "RecommendationOptionsSavingsOpportunityPercentage",
            .recommendation_options_estimated_monthly_savings_currency => "RecommendationOptionsEstimatedMonthlySavingsCurrency",
            .recommendation_options_estimated_monthly_savings_value => "RecommendationOptionsEstimatedMonthlySavingsValue",
            .recommendation_options_container_recommendations => "RecommendationOptionsContainerRecommendations",
            .recommendation_options_projected_utilization_metrics_cpu_maximum => "RecommendationOptionsProjectedUtilizationMetricsCpuMaximum",
            .recommendation_options_projected_utilization_metrics_memory_maximum => "RecommendationOptionsProjectedUtilizationMetricsMemoryMaximum",
            .tags => "Tags",
            .effective_recommendation_preferences_savings_estimation_mode => "EffectiveRecommendationPreferencesSavingsEstimationMode",
            .recommendation_options_savings_opportunity_after_discounts_percentage => "RecommendationOptionsSavingsOpportunityAfterDiscountsPercentage",
            .recommendation_options_estimated_monthly_savings_currency_after_discounts => "RecommendationOptionsEstimatedMonthlySavingsCurrencyAfterDiscounts",
            .recommendation_options_estimated_monthly_savings_value_after_discounts => "RecommendationOptionsEstimatedMonthlySavingsValueAfterDiscounts",
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
