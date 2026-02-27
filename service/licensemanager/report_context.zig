/// Details of the license configuration that this generator reports on.
pub const ReportContext = struct {
    /// Amazon Resource Names (ARNs) of the license asset groups to include in the
    /// report.
    license_asset_group_arns: ?[]const []const u8,

    /// Amazon Resource Name (ARN) of the license configuration that this generator
    /// reports on.
    license_configuration_arns: []const []const u8 = &.{},

    /// End date for the report data collection period.
    report_end_date: ?i64,

    /// Start date for the report data collection period.
    report_start_date: ?i64,

    pub const json_field_names = .{
        .license_asset_group_arns = "licenseAssetGroupArns",
        .license_configuration_arns = "licenseConfigurationArns",
        .report_end_date = "reportEndDate",
        .report_start_date = "reportStartDate",
    };
};
