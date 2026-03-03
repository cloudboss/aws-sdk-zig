/// Object that allows filtering on product title.
pub const AmiProductTitleFilter = struct {
    /// A string array of unique product title values to be filtered on.
    value_list: ?[]const []const u8 = null,

    /// A string that will be the `wildCard` input for product tile filter. It
    /// matches the provided value as a substring in the actual value.
    wild_card_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
        .wild_card_value = "WildCardValue",
    };
};
