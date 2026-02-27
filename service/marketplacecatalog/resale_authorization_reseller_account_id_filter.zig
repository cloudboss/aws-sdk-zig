/// Allows filtering on the `ResellerAccountID` of a ResaleAuthorization.
pub const ResaleAuthorizationResellerAccountIDFilter = struct {
    /// Allows filtering on the `ResellerAccountID` of a ResaleAuthorization with
    /// list input.
    value_list: ?[]const []const u8,

    /// Allows filtering on the `ResellerAccountID` of a ResaleAuthorization with
    /// wild card input.
    wild_card_value: ?[]const u8,

    pub const json_field_names = .{
        .value_list = "ValueList",
        .wild_card_value = "WildCardValue",
    };
};
