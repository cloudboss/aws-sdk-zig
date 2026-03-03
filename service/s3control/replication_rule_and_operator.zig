const S3Tag = @import("s3_tag.zig").S3Tag;

/// A container for specifying rule filters. The filters determine the subset of
/// objects to
/// which the rule applies. This element is required only if you specify more
/// than one filter.
///
/// For example:
///
/// * If you specify both a `Prefix` and a `Tag` filter, wrap
/// these filters in an `And` element.
///
/// * If you specify a filter based on multiple tags, wrap the `Tag` elements
/// in an `And` element.
pub const ReplicationRuleAndOperator = struct {
    /// An object key name prefix that identifies the subset of objects that the
    /// rule applies
    /// to.
    prefix: ?[]const u8 = null,

    /// An array of tags that contain key and value pairs.
    tags: ?[]const S3Tag = null,
};
