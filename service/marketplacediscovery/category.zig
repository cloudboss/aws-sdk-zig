/// A category used to classify a listing or product into a logical group.
pub const Category = struct {
    /// The machine-readable identifier of the category.
    category_id: []const u8,

    /// The human-readable name of the category.
    display_name: []const u8,

    pub const json_field_names = .{
        .category_id = "categoryId",
        .display_name = "displayName",
    };
};
