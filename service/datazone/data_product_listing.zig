const DetailedGlossaryTerm = @import("detailed_glossary_term.zig").DetailedGlossaryTerm;
const ListingSummary = @import("listing_summary.zig").ListingSummary;

/// The data product listing.
pub const DataProductListing = struct {
    /// The timestamp at which the data product listing was created.
    created_at: ?i64 = null,

    /// The ID of the data product listing.
    data_product_id: ?[]const u8 = null,

    /// The revision of the data product listing.
    data_product_revision: ?[]const u8 = null,

    /// The metadata forms of the data product listing.
    forms: ?[]const u8 = null,

    /// The glossary terms of the data product listing.
    glossary_terms: ?[]const DetailedGlossaryTerm = null,

    /// The data assets of the data product listing.
    items: ?[]const ListingSummary = null,

    /// The ID of the owning project of the data product listing.
    owning_project_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .data_product_id = "dataProductId",
        .data_product_revision = "dataProductRevision",
        .forms = "forms",
        .glossary_terms = "glossaryTerms",
        .items = "items",
        .owning_project_id = "owningProjectId",
    };
};
