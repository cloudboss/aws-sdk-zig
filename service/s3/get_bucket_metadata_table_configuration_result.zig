const ErrorDetails = @import("error_details.zig").ErrorDetails;
const MetadataTableConfigurationResult = @import("metadata_table_configuration_result.zig").MetadataTableConfigurationResult;

/// The V1 S3 Metadata configuration for a general purpose bucket.
///
/// If you created your S3 Metadata configuration before July 15, 2025, we
/// recommend that you delete
/// and re-create your configuration by using
/// [CreateBucketMetadataConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucketMetadataConfiguration.html) so that you can expire journal table records and create
/// a live inventory table.
pub const GetBucketMetadataTableConfigurationResult = struct {
    /// If the `CreateBucketMetadataTableConfiguration` request succeeds, but S3
    /// Metadata was
    /// unable to create the table, this structure contains the error code and error
    /// message.
    @"error": ?ErrorDetails = null,

    /// The V1 S3 Metadata configuration for a general purpose bucket.
    metadata_table_configuration_result: MetadataTableConfigurationResult,

    /// The status of the metadata table. The status values are:
    ///
    /// * `CREATING` - The metadata table is in the process of being created in the
    ///   specified
    /// table bucket.
    ///
    /// * `ACTIVE` - The metadata table has been created successfully, and records
    ///   are being
    /// delivered to the table.
    ///
    /// * `FAILED` - Amazon S3 is unable to create the metadata table, or Amazon S3
    ///   is unable to deliver
    /// records. See `ErrorDetails` for details.
    status: []const u8,
};
