const DataProductListingItemAdditionalAttributes = @import("data_product_listing_item_additional_attributes.zig").DataProductListingItemAdditionalAttributes;
const DetailedGlossaryTerm = @import("detailed_glossary_term.zig").DetailedGlossaryTerm;
const ListingSummaryItem = @import("listing_summary_item.zig").ListingSummaryItem;

/// The asset of the data product listing.
pub const DataProductListingItem = struct {
    /// The additional attributes of the asset of the data product.
    additional_attributes: ?DataProductListingItemAdditionalAttributes,

    /// The timestamp at which the asset of the data product listing was created.
    created_at: ?i64,

    /// The description of the asset of the asset of the data product.
    description: ?[]const u8,

    /// The entity ID of the asset of the asset of the data product.
    entity_id: ?[]const u8,

    /// The revision of the asset of the asset of the data product.
    entity_revision: ?[]const u8,

    /// The glossary terms of the asset of the asset of the data product.
    glossary_terms: ?[]const DetailedGlossaryTerm,

    /// The data of the asset of the data product.
    items: ?[]const ListingSummaryItem,

    /// The timestamp at which the listing was created.
    listing_created_by: ?[]const u8,

    /// The ID of the listing.
    listing_id: ?[]const u8,

    /// The revision of the listing.
    listing_revision: ?[]const u8,

    /// The user who updated the listing.
    listing_updated_by: ?[]const u8,

    /// The name of the asset of the data product.
    name: ?[]const u8,

    /// The ID of the owning project of the asset of the data product.
    owning_project_id: ?[]const u8,

    pub const json_field_names = .{
        .additional_attributes = "additionalAttributes",
        .created_at = "createdAt",
        .description = "description",
        .entity_id = "entityId",
        .entity_revision = "entityRevision",
        .glossary_terms = "glossaryTerms",
        .items = "items",
        .listing_created_by = "listingCreatedBy",
        .listing_id = "listingId",
        .listing_revision = "listingRevision",
        .listing_updated_by = "listingUpdatedBy",
        .name = "name",
        .owning_project_id = "owningProjectId",
    };
};
