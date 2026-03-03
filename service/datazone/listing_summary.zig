const DetailedGlossaryTerm = @import("detailed_glossary_term.zig").DetailedGlossaryTerm;

/// The summary of the listing of the data product.
pub const ListingSummary = struct {
    /// The glossary terms of the data product.
    glossary_terms: ?[]const DetailedGlossaryTerm = null,

    /// The ID of the data product listing.
    listing_id: ?[]const u8 = null,

    /// The revision of the data product listing.
    listing_revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .glossary_terms = "glossaryTerms",
        .listing_id = "listingId",
        .listing_revision = "listingRevision",
    };
};
