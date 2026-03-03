const S3TablesBucketType = @import("s3_tables_bucket_type.zig").S3TablesBucketType;

/// The destination information for the S3 Metadata configuration.
pub const DestinationResult = struct {
    /// The Amazon Resource Name (ARN) of the table bucket where the metadata
    /// configuration is stored.
    table_bucket_arn: ?[]const u8 = null,

    /// The type of the table bucket where the metadata configuration is stored. The
    /// `aws`
    /// value indicates an Amazon Web Services managed table bucket, and the
    /// `customer` value indicates a
    /// customer-managed table bucket. V2 metadata configurations are stored in
    /// Amazon Web Services managed table
    /// buckets, and V1 metadata configurations are stored in customer-managed table
    /// buckets.
    table_bucket_type: ?S3TablesBucketType = null,

    /// The namespace in the table bucket where the metadata tables for a metadata
    /// configuration are
    /// stored.
    table_namespace: ?[]const u8 = null,
};
