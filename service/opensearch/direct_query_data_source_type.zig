const CloudWatchDirectQueryDataSource = @import("cloud_watch_direct_query_data_source.zig").CloudWatchDirectQueryDataSource;
const SecurityLakeDirectQueryDataSource = @import("security_lake_direct_query_data_source.zig").SecurityLakeDirectQueryDataSource;

/// The type of data source that is used for direct queries. This is a supported
/// Amazon Web Services service, such as CloudWatch Logs or Security Lake.
pub const DirectQueryDataSourceType = union(enum) {
    /// Specifies CloudWatch Logs as a type of data source for direct queries.
    cloud_watch_log: ?CloudWatchDirectQueryDataSource,
    /// Specifies Security Lake as a type of data source for direct queries.
    security_lake: ?SecurityLakeDirectQueryDataSource,

    pub const json_field_names = .{
        .cloud_watch_log = "CloudWatchLog",
        .security_lake = "SecurityLake",
    };
};
