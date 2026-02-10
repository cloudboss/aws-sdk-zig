const ReplicationRuleAndOperator = @import("replication_rule_and_operator.zig").ReplicationRuleAndOperator;
const Tag = @import("tag.zig").Tag;

/// A filter that identifies the subset of objects to which the replication rule
/// applies. A
/// `Filter` must specify exactly one `Prefix`, `Tag`, or an
/// `And` child element.
pub const ReplicationRuleFilter = struct {
    /// A container for specifying rule filters. The filters determine the subset of
    /// objects to which the
    /// rule applies. This element is required only if you specify more than one
    /// filter. For example:
    ///
    /// * If you specify both a `Prefix` and a `Tag` filter, wrap these filters in
    /// an `And` tag.
    ///
    /// * If you specify a filter based on multiple tags, wrap the `Tag` elements in
    ///   an
    /// `And` tag.
    @"and": ?ReplicationRuleAndOperator,

    /// An object key name prefix that identifies the subset of objects to which the
    /// rule applies.
    ///
    /// **Important:**
    ///
    /// Replacement must be made for object keys containing special characters (such
    /// as carriage returns) when using
    /// XML requests. For more information, see [
    /// XML related object key
    /// constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints).
    prefix: ?[]const u8,

    /// A container for specifying a tag key and value.
    ///
    /// The rule applies only to objects that have the tag in their tag set.
    tag: ?Tag,
};
