pub const ReportType = enum {
    license_configuration_summary_report,
    license_configuration_usage_report,
    license_asset_group_usage_report,

    pub const json_field_names = .{
        .license_configuration_summary_report = "LICENSE_CONFIGURATION_SUMMARY_REPORT",
        .license_configuration_usage_report = "LICENSE_CONFIGURATION_USAGE_REPORT",
        .license_asset_group_usage_report = "LICENSE_ASSET_GROUP_USAGE_REPORT",
    };
};
