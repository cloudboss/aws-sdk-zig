const IntelligentTieringAndOperator = @import("intelligent_tiering_and_operator.zig").IntelligentTieringAndOperator;
const Tag = @import("tag.zig").Tag;

/// The `Filter` is used to identify objects that the S3 Intelligent-Tiering
/// configuration
/// applies to.
pub const IntelligentTieringFilter = struct {
    /// A conjunction (logical AND) of predicates, which is used in evaluating a
    /// metrics filter. The
    /// operator must have at least two predicates, and an object must match all of
    /// the predicates in order for
    /// the filter to apply.
    @"and": ?IntelligentTieringAndOperator,

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

    tag: ?Tag,
};
