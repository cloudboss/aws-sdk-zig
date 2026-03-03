/// Allows filtering on the `Name` of a ResaleAuthorization.
pub const ResaleAuthorizationNameFilter = struct {
    /// Allows filtering on the `Name` of a ResaleAuthorization with list input.
    value_list: ?[]const []const u8 = null,

    /// Allows filtering on the `Name` of a ResaleAuthorization with wild card
    /// input.
    wild_card_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
        .wild_card_value = "WildCardValue",
    };
};
