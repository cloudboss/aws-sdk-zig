const OfferStateString = @import("offer_state_string.zig").OfferStateString;

/// Allows filtering on the `State` of an offer.
pub const OfferStateFilter = struct {
    /// Allows filtering on the `State` of an offer with list input.
    value_list: ?[]const OfferStateString = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};
