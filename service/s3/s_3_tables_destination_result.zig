/// The destination information for a V1 S3 Metadata configuration. The
/// destination table bucket must
/// be in the same Region and Amazon Web Services account as the general purpose
/// bucket. The specified metadata table name
/// must be unique within the `aws_s3_metadata` namespace in the destination
/// table bucket.
///
/// **Note:**
///
/// If you created your S3 Metadata configuration before July 15, 2025, we
/// recommend that you delete
/// and re-create your configuration by using
/// [CreateBucketMetadataConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucketMetadataConfiguration.html) so that you can expire journal table records and create
/// a live inventory table.
pub const S3TablesDestinationResult = struct {
    /// The Amazon Resource Name (ARN) for the metadata table in the metadata table
    /// configuration. The
    /// specified metadata table name must be unique within the `aws_s3_metadata`
    /// namespace in the
    /// destination table bucket.
    table_arn: []const u8,

    /// The Amazon Resource Name (ARN) for the table bucket that's specified as the
    /// destination in the
    /// metadata table configuration. The destination table bucket must be in the
    /// same Region and Amazon Web Services account
    /// as the general purpose bucket.
    table_bucket_arn: []const u8,

    /// The name for the metadata table in your metadata table configuration. The
    /// specified metadata table
    /// name must be unique within the `aws_s3_metadata` namespace in the
    /// destination table bucket.
    table_name: []const u8,

    /// The table bucket namespace for the metadata table in your metadata table
    /// configuration. This value
    /// is always `aws_s3_metadata`.
    table_namespace: []const u8,
};
