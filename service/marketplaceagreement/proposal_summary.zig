const Resource = @import("resource.zig").Resource;

/// A summary of the proposal received from the proposer.
pub const ProposalSummary = struct {
    /// The unique identifier of the offer in AWS Marketplace.
    offer_id: ?[]const u8 = null,

    /// A unique identifier for the offer set containing this offer. All agreements
    /// created from offers in this set include this identifier as context.
    offer_set_id: ?[]const u8 = null,

    /// The list of resources involved in the agreement.
    resources: ?[]const Resource = null,

    pub const json_field_names = .{
        .offer_id = "offerId",
        .offer_set_id = "offerSetId",
        .resources = "resources",
    };
};
