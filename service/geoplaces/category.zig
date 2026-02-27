/// Category of the `Place` returned.
pub const Category = struct {
    /// The category ID.
    id: []const u8,

    /// Localized name of the category type.
    localized_name: ?[]const u8,

    /// The category name.
    name: []const u8,

    /// Boolean which indicates if this category is the primary offered by the
    /// place.
    primary: ?bool,

    pub const json_field_names = .{
        .id = "Id",
        .localized_name = "LocalizedName",
        .name = "Name",
        .primary = "Primary",
    };
};
