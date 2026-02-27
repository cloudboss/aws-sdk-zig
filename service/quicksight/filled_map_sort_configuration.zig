const FieldSortOptions = @import("field_sort_options.zig").FieldSortOptions;

/// The sort configuration of a `FilledMapVisual`.
pub const FilledMapSortConfiguration = struct {
    /// The sort configuration of the location fields.
    category_sort: ?[]const FieldSortOptions,

    pub const json_field_names = .{
        .category_sort = "CategorySort",
    };
};
