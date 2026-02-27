/// Specifies an S3 location where chat logs will be stored.
pub const S3DestinationConfiguration = struct {
    /// Name of the Amazon S3 bucket where chat activity will be logged.
    bucket_name: []const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
    };
};
