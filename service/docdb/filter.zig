/// A named set of filter values, used to return a more specific list of
/// results. You can
/// use a filter to match a set of resources by specific criteria, such as IDs.
///
/// Wildcards are not supported in filters.
pub const Filter = struct {
    /// The name of the filter. Filter names are case sensitive.
    name: []const u8,

    /// One or more filter values. Filter values are case sensitive.
    values: []const []const u8,
};
