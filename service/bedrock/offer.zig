const TermDetails = @import("term_details.zig").TermDetails;

/// An offer dictates usage terms for the model.
pub const Offer = struct {
    /// Offer Id for a model offer.
    offer_id: ?[]const u8,

    /// Offer token.
    offer_token: []const u8,

    /// Details about the terms of the offer.
    term_details: TermDetails,

    pub const json_field_names = .{
        .offer_id = "offerId",
        .offer_token = "offerToken",
        .term_details = "termDetails",
    };
};
