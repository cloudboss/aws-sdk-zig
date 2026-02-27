/// List of `Food` types offered by this result.
pub const FoodType = struct {
    /// The Food Type Id.
    id: ?[]const u8,

    /// Localized name of the food type.
    localized_name: []const u8,

    /// Boolean which indicates if this food type is the primary offered by the
    /// place. For example, if a location serves fast food, but also dessert, he
    /// primary would likely be fast food.
    primary: ?bool,

    pub const json_field_names = .{
        .id = "Id",
        .localized_name = "LocalizedName",
        .primary = "Primary",
    };
};
