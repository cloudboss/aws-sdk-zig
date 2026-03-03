const OfferSetStateString = @import("offer_set_state_string.zig").OfferSetStateString;

/// Summarized information about an offer set.
pub const OfferSetSummary = struct {
    /// The list of offer IDs associated with the offer set.
    associated_offer_ids: ?[]const []const u8 = null,

    /// The name of the offer set.
    name: ?[]const u8 = null,

    /// The release date of the offer set.
    release_date: ?[]const u8 = null,

    /// The solution ID associated with the offer set.
    solution_id: ?[]const u8 = null,

    /// The state of the offer set.
    state: ?OfferSetStateString = null,

    pub const json_field_names = .{
        .associated_offer_ids = "AssociatedOfferIds",
        .name = "Name",
        .release_date = "ReleaseDate",
        .solution_id = "SolutionId",
        .state = "State",
    };
};
