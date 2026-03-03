const ReplicationRuleAndOperator = @import("replication_rule_and_operator.zig").ReplicationRuleAndOperator;
const S3Tag = @import("s3_tag.zig").S3Tag;

/// A filter that identifies the subset of objects to which the replication rule
/// applies. A
/// `Filter` element must specify exactly one `Prefix`,
/// `Tag`, or `And` child element.
pub const ReplicationRuleFilter = struct {
    /// A container for specifying rule filters. The filters determine the subset of
    /// objects
    /// that the rule applies to. This element is required only if you specify more
    /// than one
    /// filter. For example:
    ///
    /// * If you specify both a `Prefix` and a `Tag` filter, wrap
    /// these filters in an `And` element.
    ///
    /// * If you specify a filter based on multiple tags, wrap the `Tag` elements
    /// in an `And` element.
    @"and": ?ReplicationRuleAndOperator = null,

    /// An object key name prefix that identifies the subset of objects that the
    /// rule applies
    /// to.
    ///
    /// When you're using XML requests, you must
    /// replace special characters (such as carriage returns) in object keys with
    /// their equivalent XML entity codes.
    /// For more information, see [
    /// XML-related object key
    /// constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints) in the *Amazon S3 User Guide*.
    prefix: ?[]const u8 = null,

    tag: ?S3Tag = null,
};
