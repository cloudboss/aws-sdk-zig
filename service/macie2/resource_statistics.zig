/// Provides statistical data for sensitive data discovery metrics that apply to
/// an S3 bucket that Amazon Macie monitors and analyzes for an account, if
/// automated sensitive data discovery has been enabled for the account. The
/// data captures the results of automated sensitive data discovery activities
/// that Macie has performed for the bucket.
pub const ResourceStatistics = struct {
    /// The total amount of data, in bytes, that Amazon Macie has analyzed in the
    /// bucket.
    total_bytes_classified: ?i64 = null,

    /// The total number of occurrences of sensitive data that Amazon Macie has
    /// found in the bucket's objects. This includes occurrences that are currently
    /// suppressed by the sensitivity scoring settings for the bucket
    /// (totalDetectionsSuppressed).
    total_detections: ?i64 = null,

    /// The total number of occurrences of sensitive data that are currently
    /// suppressed by the sensitivity scoring settings for the bucket. These
    /// represent occurrences of sensitive data that Amazon Macie found in the
    /// bucket's objects, but the occurrences were manually suppressed. By default,
    /// suppressed occurrences are excluded from the bucket's sensitivity score.
    total_detections_suppressed: ?i64 = null,

    /// The total number of objects that Amazon Macie has analyzed in the bucket.
    total_items_classified: ?i64 = null,

    /// The total number of the bucket's objects that Amazon Macie has found
    /// sensitive data in.
    total_items_sensitive: ?i64 = null,

    /// The total number of objects that Amazon Macie wasn't able to analyze in the
    /// bucket due to an object-level issue or error. For example, an object is a
    /// malformed file. This value includes objects that Macie wasn't able to
    /// analyze for reasons reported by other statistics in the ResourceStatistics
    /// object.
    total_items_skipped: ?i64 = null,

    /// The total number of objects that Amazon Macie wasn't able to analyze in the
    /// bucket because the objects are encrypted with a key that Macie can't access.
    /// The objects use server-side encryption with customer-provided keys (SSE-C).
    total_items_skipped_invalid_encryption: ?i64 = null,

    /// The total number of objects that Amazon Macie wasn't able to analyze in the
    /// bucket because the objects are encrypted with KMS keys that were disabled,
    /// are scheduled for deletion, or were deleted.
    total_items_skipped_invalid_kms: ?i64 = null,

    /// The total number of objects that Amazon Macie wasn't able to analyze in the
    /// bucket due to the permissions settings for the objects or the permissions
    /// settings for the keys that were used to encrypt the objects.
    total_items_skipped_permission_denied: ?i64 = null,

    pub const json_field_names = .{
        .total_bytes_classified = "totalBytesClassified",
        .total_detections = "totalDetections",
        .total_detections_suppressed = "totalDetectionsSuppressed",
        .total_items_classified = "totalItemsClassified",
        .total_items_sensitive = "totalItemsSensitive",
        .total_items_skipped = "totalItemsSkipped",
        .total_items_skipped_invalid_encryption = "totalItemsSkippedInvalidEncryption",
        .total_items_skipped_invalid_kms = "totalItemsSkippedInvalidKms",
        .total_items_skipped_permission_denied = "totalItemsSkippedPermissionDenied",
    };
};
