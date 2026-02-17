const S3TablesDestinationResult = @import("s3_tables_destination_result.zig").S3TablesDestinationResult;

/// The V1 S3 Metadata configuration for a general purpose bucket. The
/// destination table bucket must be
/// in the same Region and Amazon Web Services account as the general purpose
/// bucket. The specified metadata table name
/// must be unique within the `aws_s3_metadata` namespace in the destination
/// table bucket.
///
/// If you created your S3 Metadata configuration before July 15, 2025, we
/// recommend that you delete
/// and re-create your configuration by using
/// [CreateBucketMetadataConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucketMetadataConfiguration.html) so that you can expire journal table records and create
/// a live inventory table.
pub const MetadataTableConfigurationResult = struct {
    /// The destination information for the metadata table configuration. The
    /// destination table bucket must
    /// be in the same Region and Amazon Web Services account as the general purpose
    /// bucket. The specified metadata table name
    /// must be unique within the `aws_s3_metadata` namespace in the destination
    /// table bucket.
    s3_tables_destination_result: S3TablesDestinationResult,
};
