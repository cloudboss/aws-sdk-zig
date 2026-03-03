const OfferTargetingString = @import("offer_targeting_string.zig").OfferTargetingString;

/// Allows filtering on the `Targeting` of an offer.
pub const OfferTargetingFilter = struct {
    /// Allows filtering on the `Targeting` of an offer with list input.
    value_list: ?[]const OfferTargetingString = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};
