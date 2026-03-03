const ExperimentTemplateReportConfigurationCloudWatchDashboard = @import("experiment_template_report_configuration_cloud_watch_dashboard.zig").ExperimentTemplateReportConfigurationCloudWatchDashboard;

/// Describes the data sources for the experiment report.
pub const ExperimentTemplateReportConfigurationDataSources = struct {
    /// The CloudWatch dashboards to include as data sources in the experiment
    /// report.
    cloud_watch_dashboards: ?[]const ExperimentTemplateReportConfigurationCloudWatchDashboard = null,

    pub const json_field_names = .{
        .cloud_watch_dashboards = "cloudWatchDashboards",
    };
};
