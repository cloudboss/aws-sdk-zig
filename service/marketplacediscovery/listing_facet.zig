/// A facet value with display information and a count of matching listings.
/// Used to build filter and browse experiences.
pub const ListingFacet = struct {
    /// The number of listings matching this facet value.
    count: i64,

    /// The human-readable name of the facet value, suitable for display in a user
    /// interface.
    display_name: []const u8,

    /// The parent facet value for hierarchical facets, such as subcategories.
    parent: ?[]const u8 = null,

    /// The internal value used for filtering when passed back in a search filter.
    value: []const u8,

    pub const json_field_names = .{
        .count = "count",
        .display_name = "displayName",
        .parent = "parent",
        .value = "value",
    };
};
