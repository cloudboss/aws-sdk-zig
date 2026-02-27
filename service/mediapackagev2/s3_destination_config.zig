/// Configuration parameters for where in an S3 bucket to place the harvested
/// content.
pub const S3DestinationConfig = struct {
    /// The name of an S3 bucket within which harvested content will be exported.
    bucket_name: []const u8,

    /// The path within the specified S3 bucket where the harvested content will be
    /// placed.
    destination_path: []const u8,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .destination_path = "DestinationPath",
    };
};
