const ExperimentReportConfigurationCloudWatchDashboard = @import("experiment_report_configuration_cloud_watch_dashboard.zig").ExperimentReportConfigurationCloudWatchDashboard;

/// Describes the data sources for the experiment report.
pub const ExperimentReportConfigurationDataSources = struct {
    /// The CloudWatch dashboards to include as data sources in the experiment
    /// report.
    cloud_watch_dashboards: ?[]const ExperimentReportConfigurationCloudWatchDashboard = null,

    pub const json_field_names = .{
        .cloud_watch_dashboards = "cloudWatchDashboards",
    };
};
