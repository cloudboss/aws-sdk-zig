const DeleteMarkerReplication = @import("delete_marker_replication.zig").DeleteMarkerReplication;
const Destination = @import("destination.zig").Destination;
const ExistingObjectReplication = @import("existing_object_replication.zig").ExistingObjectReplication;
const ReplicationRuleFilter = @import("replication_rule_filter.zig").ReplicationRuleFilter;
const SourceSelectionCriteria = @import("source_selection_criteria.zig").SourceSelectionCriteria;
const ReplicationRuleStatus = @import("replication_rule_status.zig").ReplicationRuleStatus;

/// Specifies which S3 on Outposts objects to replicate and where to store the
/// replicas.
pub const ReplicationRule = struct {
    /// The Amazon Resource Name (ARN) of the access point for the source Outposts
    /// bucket that you want
    /// S3 on Outposts to replicate the objects from.
    bucket: []const u8,

    /// Specifies whether S3 on Outposts replicates delete markers. If you specify a
    /// `Filter` element in your replication configuration, you must also include a
    /// `DeleteMarkerReplication` element. If your `Filter` includes a
    /// `Tag` element, the `DeleteMarkerReplication` element's
    /// `Status` child element must be set to `Disabled`, because
    /// S3 on Outposts doesn't support replicating delete markers for tag-based
    /// rules.
    ///
    /// For more information about delete marker replication, see [How delete
    /// operations affect
    /// replication](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3OutpostsReplication.html#outposts-replication-what-is-replicated) in the
    /// *Amazon S3 User Guide*.
    delete_marker_replication: ?DeleteMarkerReplication,

    /// A container for information about the replication destination and its
    /// configurations.
    destination: Destination,

    /// An optional configuration to replicate existing source bucket objects.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    existing_object_replication: ?ExistingObjectReplication,

    /// A filter that identifies the subset of objects to which the replication rule
    /// applies. A
    /// `Filter` element must specify exactly one `Prefix`,
    /// `Tag`, or `And` child element.
    filter: ?ReplicationRuleFilter,

    /// A unique identifier for the rule. The maximum value is 255 characters.
    id: ?[]const u8,

    /// An object key name prefix that identifies the object or objects to which the
    /// rule
    /// applies. The maximum prefix length is 1,024 characters. To include all
    /// objects in an
    /// Outposts bucket, specify an empty string.
    ///
    /// When you're using XML requests, you must
    /// replace special characters (such as carriage returns) in object keys with
    /// their equivalent XML entity codes.
    /// For more information, see [
    /// XML-related object key
    /// constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints) in the *Amazon S3 User Guide*.
    prefix: ?[]const u8,

    /// The priority indicates which rule has precedence whenever two or more
    /// replication rules
    /// conflict. S3 on Outposts attempts to replicate objects according to all
    /// replication rules.
    /// However, if there are two or more rules with the same destination Outposts
    /// bucket, then
    /// objects will be replicated according to the rule with the highest priority.
    /// The higher the
    /// number, the higher the priority.
    ///
    /// For more information, see [Creating replication
    /// rules on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/replication-between-outposts.html) in the *Amazon S3 User Guide*.
    priority: ?i32,

    /// A container that describes additional filters for identifying the source
    /// Outposts
    /// objects that you want to replicate. You can choose to enable or disable the
    /// replication of
    /// these objects.
    source_selection_criteria: ?SourceSelectionCriteria,

    /// Specifies whether the rule is enabled.
    status: ReplicationRuleStatus,
};
