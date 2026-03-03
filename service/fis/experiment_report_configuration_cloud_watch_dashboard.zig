/// Specifies the CloudWatch dashboard to include in the experiment report. The
/// dashboard widgets will be captured as snapshot graphs within the report.
pub const ExperimentReportConfigurationCloudWatchDashboard = struct {
    /// The Amazon Resource Name (ARN) of the CloudWatch dashboard to include in the
    /// experiment report.
    dashboard_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .dashboard_identifier = "dashboardIdentifier",
    };
};
