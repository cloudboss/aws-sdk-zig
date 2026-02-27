/// A string to string map of the configuration details for theme generation.
pub const FieldsForThemeGeneration = struct {
    /// The name of the Items dataset column that stores the name of each item in
    /// the dataset.
    item_name: []const u8,

    pub const json_field_names = .{
        .item_name = "itemName",
    };
};
