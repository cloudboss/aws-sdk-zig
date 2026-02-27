/// The ground truth labels for the dataset used for the monitoring job.
pub const MonitoringGroundTruthS3Input = struct {
    /// The address of the Amazon S3 location of the ground truth labels.
    s3_uri: ?[]const u8,

    pub const json_field_names = .{
        .s3_uri = "S3Uri",
    };
};
