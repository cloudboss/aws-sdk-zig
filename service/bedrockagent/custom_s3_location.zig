/// Contains information about the Amazon S3 location of the file containing the
/// content to ingest into a knowledge base connected to a custom data source.
pub const CustomS3Location = struct {
    /// The identifier of the Amazon Web Services account that owns the S3 bucket
    /// containing the content to ingest.
    bucket_owner_account_id: ?[]const u8 = null,

    /// The S3 URI of the file containing the content to ingest.
    uri: []const u8,

    pub const json_field_names = .{
        .bucket_owner_account_id = "bucketOwnerAccountId",
        .uri = "uri",
    };
};
