/// Maps a particular data source sync job to a particular data source.
pub const DataSourceSyncJobMetricTarget = struct {
    /// The ID of the data source that is running the sync job.
    data_source_id: []const u8,

    /// The ID of the sync job that is running on the data source.
    ///
    /// If the ID of a sync job is not provided and there is a sync job running,
    /// then the ID of
    /// this sync job is used and metrics are generated for this sync job.
    ///
    /// If the ID of a sync job is not provided and there is no sync job running,
    /// then no metrics
    /// are generated and documents are indexed/deleted at the index level without
    /// sync job metrics
    /// included.
    data_source_sync_job_id: ?[]const u8,

    pub const json_field_names = .{
        .data_source_id = "DataSourceId",
        .data_source_sync_job_id = "DataSourceSyncJobId",
    };
};
