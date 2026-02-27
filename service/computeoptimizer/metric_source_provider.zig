pub const MetricSourceProvider = enum {
    cloud_watch_app_insights,

    pub const json_field_names = .{
        .cloud_watch_app_insights = "CloudWatchAppInsights",
    };
};
