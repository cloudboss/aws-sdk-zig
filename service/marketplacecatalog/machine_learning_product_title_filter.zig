/// The filter for machine learning product titles.
pub const MachineLearningProductTitleFilter = struct {
    /// A list of product titles to filter by. The operation returns machine
    /// learning products with titles that exactly match the values in this list.
    value_list: ?[]const []const u8 = null,

    /// A wildcard value to filter product titles. The operation returns machine
    /// learning products with titles that match this wildcard pattern.
    wild_card_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
        .wild_card_value = "WildCardValue",
    };
};
