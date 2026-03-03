const Tag = @import("tag.zig").Tag;

/// A container for specifying rule filters. The filters determine the subset of
/// objects to which the
/// rule applies. This element is required only if you specify more than one
/// filter.
///
/// For example:
///
/// * If you specify both a `Prefix` and a `Tag` filter, wrap these filters in
/// an `And` tag.
///
/// * If you specify a filter based on multiple tags, wrap the `Tag` elements in
///   an
/// `And` tag.
pub const ReplicationRuleAndOperator = struct {
    /// An object key name prefix that identifies the subset of objects to which the
    /// rule applies.
    prefix: ?[]const u8 = null,

    /// An array of tags containing key and value pairs.
    tags: ?[]const Tag = null,
};
