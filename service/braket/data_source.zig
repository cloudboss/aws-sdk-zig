const S3DataSource = @import("s3_data_source.zig").S3DataSource;

/// Information about the source of the input data used by the Amazon Braket
/// hybrid job.
pub const DataSource = struct {
    /// Amazon S3 path of the input data used by the hybrid job.
    s_3_data_source: S3DataSource,

    pub const json_field_names = .{
        .s_3_data_source = "s3DataSource",
    };
};
