const DeleteMarkerReplication = @import("delete_marker_replication.zig").DeleteMarkerReplication;
const Destination = @import("destination.zig").Destination;
const ExistingObjectReplication = @import("existing_object_replication.zig").ExistingObjectReplication;
const ReplicationRuleFilter = @import("replication_rule_filter.zig").ReplicationRuleFilter;
const SourceSelectionCriteria = @import("source_selection_criteria.zig").SourceSelectionCriteria;
const ReplicationRuleStatus = @import("replication_rule_status.zig").ReplicationRuleStatus;

/// Specifies which Amazon S3 objects to replicate and where to store the
/// replicas.
pub const ReplicationRule = struct {
    delete_marker_replication: ?DeleteMarkerReplication,

    /// A container for information about the replication destination and its
    /// configurations including
    /// enabling the S3 Replication Time Control (S3 RTC).
    destination: Destination,

    /// Optional configuration to replicate existing source bucket objects.
    ///
    /// This parameter is no longer supported. To replicate existing objects, see
    /// [Replicating
    /// existing objects with S3 Batch
    /// Replication](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-batch-replication-batch.html) in the
    /// *Amazon S3 User Guide*.
    existing_object_replication: ?ExistingObjectReplication,

    filter: ?ReplicationRuleFilter,

    /// A unique identifier for the rule. The maximum value is 255 characters.
    id: ?[]const u8,

    /// An object key name prefix that identifies the object or objects to which the
    /// rule applies. The
    /// maximum prefix length is 1,024 characters. To include all objects in a
    /// bucket, specify an empty string.
    ///
    /// Replacement must be made for object keys containing special characters (such
    /// as carriage returns) when using
    /// XML requests. For more information, see [
    /// XML related object key
    /// constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints).
    prefix: ?[]const u8,

    /// The priority indicates which rule has precedence whenever two or more
    /// replication rules conflict.
    /// Amazon S3 will attempt to replicate objects according to all replication
    /// rules. However, if there are two or
    /// more rules with the same destination bucket, then objects will be replicated
    /// according to the rule with
    /// the highest priority. The higher the number, the higher the priority.
    ///
    /// For more information, see
    /// [Replication](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication.html) in the *Amazon S3 User Guide*.
    priority: ?i32,

    /// A container that describes additional filters for identifying the source
    /// objects that you want to
    /// replicate. You can choose to enable or disable the replication of these
    /// objects. Currently, Amazon S3
    /// supports only the filter that you can specify for objects created with
    /// server-side encryption using a
    /// customer managed key stored in Amazon Web Services Key Management Service
    /// (SSE-KMS).
    source_selection_criteria: ?SourceSelectionCriteria,

    /// Specifies whether the rule is enabled.
    status: ReplicationRuleStatus,
};
