/// Specifies the CloudWatch dashboard for the experiment report.
pub const ReportConfigurationCloudWatchDashboardInput = struct {
    /// The Amazon Resource Name (ARN) of the CloudWatch dashboard to include in the
    /// experiment report.
    dashboard_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .dashboard_identifier = "dashboardIdentifier",
    };
};
