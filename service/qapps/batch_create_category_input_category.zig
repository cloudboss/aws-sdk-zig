/// The category object to be created.
pub const BatchCreateCategoryInputCategory = struct {
    /// The color to be associated with a category. The color must be a hexadecimal
    /// value of either 3 or 6 digits.
    color: ?[]const u8,

    /// The unique identifier to be associated with a category. If you don't include
    /// a value, the category is automatically assigned a unique identifier.
    id: ?[]const u8,

    /// The name of the category.
    title: []const u8,

    pub const json_field_names = .{
        .color = "color",
        .id = "id",
        .title = "title",
    };
};
