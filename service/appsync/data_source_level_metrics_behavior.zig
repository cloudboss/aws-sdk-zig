pub const DataSourceLevelMetricsBehavior = enum {
    full_request_data_source_metrics,
    per_data_source_metrics,

    pub const json_field_names = .{
        .full_request_data_source_metrics = "FULL_REQUEST_DATA_SOURCE_METRICS",
        .per_data_source_metrics = "PER_DATA_SOURCE_METRICS",
    };
};
