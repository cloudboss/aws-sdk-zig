/// Contains detailed information about a report setting.
pub const ReportSetting = struct {
    /// These are the accounts to be included in the report.
    ///
    /// Use string value of `ROOT` to include all organizational units.
    accounts: ?[]const []const u8,

    /// The Amazon Resource Names (ARNs) of the frameworks a report covers.
    framework_arns: ?[]const []const u8,

    /// The number of frameworks a report covers.
    number_of_frameworks: i32 = 0,

    /// These are the Organizational Units to be included in the report.
    organization_units: ?[]const []const u8,

    /// These are the Regions to be included in the report.
    ///
    /// Use the wildcard as the string value to include all Regions.
    regions: ?[]const []const u8,

    /// Identifies the report template for the report. Reports are built using a
    /// report
    /// template. The report templates are:
    ///
    /// `RESOURCE_COMPLIANCE_REPORT | CONTROL_COMPLIANCE_REPORT | BACKUP_JOB_REPORT
    /// |
    /// COPY_JOB_REPORT | RESTORE_JOB_REPORT | SCAN_JOB_REPORT`
    report_template: []const u8,

    pub const json_field_names = .{
        .accounts = "Accounts",
        .framework_arns = "FrameworkArns",
        .number_of_frameworks = "NumberOfFrameworks",
        .organization_units = "OrganizationUnits",
        .regions = "Regions",
        .report_template = "ReportTemplate",
    };
};
