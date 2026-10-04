/// The details of the renewal that applies at the end date of an agreement.
pub const RenewalSummary = struct {
    /// The unique identifier of the offer that provides the terms for the next
    /// renewal cycle. For most renewals, this is the same offer that the agreement
    /// was created from.
    offer_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .offer_id = "offerId",
    };
};
