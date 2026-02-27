/// A label that web experience users associate with a library item. Web
/// experience users use Categories to tag and filter library items.
pub const CategoryInput = struct {
    /// The color of the category, represented as a hexadecimal value of either 3 or
    /// 6 digits.
    color: ?[]const u8,

    /// The unique identifier of the category.
    id: []const u8,

    /// The name of the category.
    title: []const u8,

    pub const json_field_names = .{
        .color = "color",
        .id = "id",
        .title = "title",
    };
};
