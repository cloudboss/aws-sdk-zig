const OfferSetStateString = @import("offer_set_state_string.zig").OfferSetStateString;

/// Allows filtering on the `State` of an offer set.
pub const OfferSetStateFilter = struct {
    /// Allows filtering on the `State` of an offer set with list input.
    value_list: ?[]const OfferSetStateString,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};
