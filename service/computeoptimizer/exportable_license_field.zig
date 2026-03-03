const std = @import("std");

pub const ExportableLicenseField = enum {
    account_id,
    resource_arn,
    lookback_period_in_days,
    last_refresh_timestamp,
    license_finding,
    license_finding_reason_codes,
    current_license_configuration_number_of_cores,
    current_license_configuration_instance_type,
    current_license_configuration_operating_system,
    current_license_configuration_license_name,
    current_license_configuration_license_edition,
    current_license_configuration_license_model,
    current_license_configuration_license_version,
    current_license_configuration_metrics_source,
    recommendation_options_operating_system,
    recommendation_options_license_edition,
    recommendation_options_license_model,
    recommendation_options_savings_opportunity_percentage,
    recommendation_options_estimated_monthly_savings_currency,
    recommendation_options_estimated_monthly_savings_value,
    tags,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .resource_arn = "ResourceArn",
        .lookback_period_in_days = "LookbackPeriodInDays",
        .last_refresh_timestamp = "LastRefreshTimestamp",
        .license_finding = "Finding",
        .license_finding_reason_codes = "FindingReasonCodes",
        .current_license_configuration_number_of_cores = "CurrentLicenseConfigurationNumberOfCores",
        .current_license_configuration_instance_type = "CurrentLicenseConfigurationInstanceType",
        .current_license_configuration_operating_system = "CurrentLicenseConfigurationOperatingSystem",
        .current_license_configuration_license_name = "CurrentLicenseConfigurationLicenseName",
        .current_license_configuration_license_edition = "CurrentLicenseConfigurationLicenseEdition",
        .current_license_configuration_license_model = "CurrentLicenseConfigurationLicenseModel",
        .current_license_configuration_license_version = "CurrentLicenseConfigurationLicenseVersion",
        .current_license_configuration_metrics_source = "CurrentLicenseConfigurationMetricsSource",
        .recommendation_options_operating_system = "RecommendationOptionsOperatingSystem",
        .recommendation_options_license_edition = "RecommendationOptionsLicenseEdition",
        .recommendation_options_license_model = "RecommendationOptionsLicenseModel",
        .recommendation_options_savings_opportunity_percentage = "RecommendationOptionsSavingsOpportunityPercentage",
        .recommendation_options_estimated_monthly_savings_currency = "RecommendationOptionsEstimatedMonthlySavingsCurrency",
        .recommendation_options_estimated_monthly_savings_value = "RecommendationOptionsEstimatedMonthlySavingsValue",
        .tags = "Tags",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_id => "AccountId",
            .resource_arn => "ResourceArn",
            .lookback_period_in_days => "LookbackPeriodInDays",
            .last_refresh_timestamp => "LastRefreshTimestamp",
            .license_finding => "Finding",
            .license_finding_reason_codes => "FindingReasonCodes",
            .current_license_configuration_number_of_cores => "CurrentLicenseConfigurationNumberOfCores",
            .current_license_configuration_instance_type => "CurrentLicenseConfigurationInstanceType",
            .current_license_configuration_operating_system => "CurrentLicenseConfigurationOperatingSystem",
            .current_license_configuration_license_name => "CurrentLicenseConfigurationLicenseName",
            .current_license_configuration_license_edition => "CurrentLicenseConfigurationLicenseEdition",
            .current_license_configuration_license_model => "CurrentLicenseConfigurationLicenseModel",
            .current_license_configuration_license_version => "CurrentLicenseConfigurationLicenseVersion",
            .current_license_configuration_metrics_source => "CurrentLicenseConfigurationMetricsSource",
            .recommendation_options_operating_system => "RecommendationOptionsOperatingSystem",
            .recommendation_options_license_edition => "RecommendationOptionsLicenseEdition",
            .recommendation_options_license_model => "RecommendationOptionsLicenseModel",
            .recommendation_options_savings_opportunity_percentage => "RecommendationOptionsSavingsOpportunityPercentage",
            .recommendation_options_estimated_monthly_savings_currency => "RecommendationOptionsEstimatedMonthlySavingsCurrency",
            .recommendation_options_estimated_monthly_savings_value => "RecommendationOptionsEstimatedMonthlySavingsValue",
            .tags => "Tags",
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
