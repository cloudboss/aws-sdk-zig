const LambdaInvokeOperation = @import("lambda_invoke_operation.zig").LambdaInvokeOperation;
const S3ComputeObjectChecksumOperation = @import("s3_compute_object_checksum_operation.zig").S3ComputeObjectChecksumOperation;
const S3DeleteObjectTaggingOperation = @import("s3_delete_object_tagging_operation.zig").S3DeleteObjectTaggingOperation;
const S3InitiateRestoreObjectOperation = @import("s3_initiate_restore_object_operation.zig").S3InitiateRestoreObjectOperation;
const S3SetObjectAclOperation = @import("s3_set_object_acl_operation.zig").S3SetObjectAclOperation;
const S3CopyObjectOperation = @import("s3_copy_object_operation.zig").S3CopyObjectOperation;
const S3SetObjectLegalHoldOperation = @import("s3_set_object_legal_hold_operation.zig").S3SetObjectLegalHoldOperation;
const S3SetObjectRetentionOperation = @import("s3_set_object_retention_operation.zig").S3SetObjectRetentionOperation;
const S3SetObjectTaggingOperation = @import("s3_set_object_tagging_operation.zig").S3SetObjectTaggingOperation;
const S3ReplicateObjectOperation = @import("s3_replicate_object_operation.zig").S3ReplicateObjectOperation;
const S3UpdateObjectEncryptionOperation = @import("s3_update_object_encryption_operation.zig").S3UpdateObjectEncryptionOperation;

/// The operation that you want this job to perform on every object listed in
/// the manifest.
/// For more information about the available operations, see
/// [Operations](https://docs.aws.amazon.com/AmazonS3/latest/dev/batch-ops-operations.html) in the
/// *Amazon S3 User Guide*.
pub const JobOperation = struct {
    /// Directs the specified job to invoke an Lambda function on every object in
    /// the
    /// manifest.
    lambda_invoke: ?LambdaInvokeOperation,

    /// Directs the specified job to compute checksum values for every object in the
    /// manifest.
    s3_compute_object_checksum: ?S3ComputeObjectChecksumOperation,

    /// Directs the specified job to execute a DELETE Object tagging call on every
    /// object in the
    /// manifest.
    ///
    /// This functionality is not supported by directory buckets.
    s3_delete_object_tagging: ?S3DeleteObjectTaggingOperation,

    /// Directs the specified job to initiate restore requests for every archived
    /// object in the
    /// manifest.
    ///
    /// This functionality is not supported by directory buckets.
    s3_initiate_restore_object: ?S3InitiateRestoreObjectOperation,

    /// Directs the specified job to run a `PutObjectAcl` call on every object in
    /// the
    /// manifest.
    ///
    /// This functionality is not supported by directory buckets.
    s3_put_object_acl: ?S3SetObjectAclOperation,

    /// Directs the specified job to run a PUT Copy object call on every object in
    /// the
    /// manifest.
    s3_put_object_copy: ?S3CopyObjectOperation,

    s3_put_object_legal_hold: ?S3SetObjectLegalHoldOperation,

    s3_put_object_retention: ?S3SetObjectRetentionOperation,

    /// Directs the specified job to run a PUT Object tagging call on every object
    /// in the
    /// manifest.
    ///
    /// This functionality is not supported by directory buckets.
    s3_put_object_tagging: ?S3SetObjectTaggingOperation,

    /// Directs the specified job to invoke `ReplicateObject` on every object in the
    /// job's manifest.
    ///
    /// This functionality is not supported by directory buckets.
    s3_replicate_object: ?S3ReplicateObjectOperation,

    /// Updates the server-side encryption type of an existing encrypted
    /// object in a general purpose bucket. You can use the `UpdateObjectEncryption`
    /// operation to change encrypted objects from server-side encryption with
    /// Amazon S3 managed keys (SSE-S3) to server-side encryption with Key
    /// Management Service (KMS)
    /// keys (SSE-KMS), or to apply S3 Bucket Keys. You can also use the
    /// `UpdateObjectEncryption` operation to change the customer-managed
    /// KMS key used to encrypt your data so that you can comply with custom
    /// key-rotation standards.
    s3_update_object_encryption: ?S3UpdateObjectEncryptionOperation,
};
