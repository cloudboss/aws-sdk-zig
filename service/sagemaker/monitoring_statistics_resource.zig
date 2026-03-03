/// The statistics resource for a monitoring job.
pub const MonitoringStatisticsResource = struct {
    /// The Amazon S3 URI for the statistics resource.
    s3_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .s3_uri = "S3Uri",
    };
};
