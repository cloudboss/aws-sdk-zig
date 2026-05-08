/// A tag filter that specifies a tag key and optional tag values for filtering
/// log
/// groups by tags.
pub const TagFilter = struct {
    /// The tag key to filter on.
    key: []const u8,

    /// An optional list of tag values to filter on.
    ///
    /// * If you specify a filter that contains more than one value for a key,
    /// the response returns log groups that match any of the specified values for
    /// that key.
    ///
    /// * If you don't specify values, the response returns all log groups that are
    /// tagged with that key, with any or no value.
    ///
    /// * Use `*` for wildcard matching. For example,
    /// `prod*` matches values that start with `prod`.
    ///
    /// * Use `!` as a prefix for negation. For example,
    /// `!prod` matches values that are not `prod`.
    ///
    /// * Exact matching and negation are case-sensitive. Wildcard matching is
    /// case-insensitive.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "key",
        .values = "values",
    };
};
