const AIWorkloadS3DataSource = @import("ai_workload_s3_data_source.zig").AIWorkloadS3DataSource;

/// The data source for an AI workload input data channel.
pub const AIWorkloadDataSource = struct {
    /// The Amazon S3 data source configuration.
    s3_data_source: ?AIWorkloadS3DataSource = null,

    pub const json_field_names = .{
        .s3_data_source = "S3DataSource",
    };
};
