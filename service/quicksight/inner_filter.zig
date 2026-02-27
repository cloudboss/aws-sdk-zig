const CategoryInnerFilter = @import("category_inner_filter.zig").CategoryInnerFilter;

/// The `InnerFilter` defines the subset of data to be used with the
/// `NestedFilter`.
pub const InnerFilter = struct {
    /// A `CategoryInnerFilter` filters text values for the `NestedFilter`.
    category_inner_filter: ?CategoryInnerFilter,

    pub const json_field_names = .{
        .category_inner_filter = "CategoryInnerFilter",
    };
};
