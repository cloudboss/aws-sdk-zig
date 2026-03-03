const ReportConfigurationCloudWatchDashboardInput = @import("report_configuration_cloud_watch_dashboard_input.zig").ReportConfigurationCloudWatchDashboardInput;

/// Specifies the data sources for the experiment report.
pub const ExperimentTemplateReportConfigurationDataSourcesInput = struct {
    /// The CloudWatch dashboards to include as data sources in the experiment
    /// report.
    cloud_watch_dashboards: ?[]const ReportConfigurationCloudWatchDashboardInput = null,

    pub const json_field_names = .{
        .cloud_watch_dashboards = "cloudWatchDashboards",
    };
};
