const TableSseAlgorithm = @import("table_sse_algorithm.zig").TableSseAlgorithm;

/// The encryption settings for an S3 Metadata journal table or inventory table
/// configuration.
pub const MetadataTableEncryptionConfiguration = struct {
    /// If server-side encryption with Key Management Service (KMS) keys (SSE-KMS)
    /// is specified, you must also
    /// specify the KMS key Amazon Resource Name (ARN). You must specify a
    /// customer-managed KMS key
    /// that's located in the same Region as the general purpose bucket that
    /// corresponds to the metadata
    /// table configuration.
    kms_key_arn: ?[]const u8 = null,

    /// The encryption type specified for a metadata table. To specify server-side
    /// encryption with
    /// Key Management Service (KMS) keys (SSE-KMS), use the `aws:kms` value. To
    /// specify server-side
    /// encryption with Amazon S3 managed keys (SSE-S3), use the `AES256` value.
    sse_algorithm: TableSseAlgorithm,
};
