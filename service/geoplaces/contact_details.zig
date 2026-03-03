const Category = @import("category.zig").Category;

/// Details related to contacts.
pub const ContactDetails = struct {
    /// Categories of results that results must belong too.
    categories: ?[]const Category = null,

    /// The contact's label.
    label: ?[]const u8 = null,

    /// The contact's value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .categories = "Categories",
        .label = "Label",
        .value = "Value",
    };
};
