/// A category used to classify and filter library items for Amazon Q Apps.
pub const Category = struct {
    /// The number of published Amazon Q Apps associated with a category
    app_count: ?i32 = null,

    /// The color of the category
    color: ?[]const u8 = null,

    /// The unique identifier of the category.
    id: []const u8,

    /// The title or name of the category.
    title: []const u8,

    pub const json_field_names = .{
        .app_count = "appCount",
        .color = "color",
        .id = "id",
        .title = "title",
    };
};
