const AssetListingItemAdditionalAttributes = @import("asset_listing_item_additional_attributes.zig").AssetListingItemAdditionalAttributes;
const DetailedGlossaryTerm = @import("detailed_glossary_term.zig").DetailedGlossaryTerm;

/// The details of an asset published in an Amazon DataZone catalog.
pub const AssetListingItem = struct {
    /// The additional attributes of an asset published in an Amazon DataZone
    /// catalog.
    additional_attributes: ?AssetListingItemAdditionalAttributes,

    /// The timestamp of when an asset published in an Amazon DataZone catalog was
    /// created.
    created_at: ?i64,

    /// The description of an asset published in an Amazon DataZone catalog.
    description: ?[]const u8,

    /// The identifier of the inventory asset.
    entity_id: ?[]const u8,

    /// The revision of the inventory asset.
    entity_revision: ?[]const u8,

    /// The type of the inventory asset.
    entity_type: ?[]const u8,

    /// Glossary terms attached to the inventory asset.
    glossary_terms: ?[]const DetailedGlossaryTerm,

    /// The restricted glossary terms associated with an asset.
    governed_glossary_terms: ?[]const DetailedGlossaryTerm,

    /// The Amazon DataZone user who created the listing.
    listing_created_by: ?[]const u8,

    /// The identifier of the listing (asset published in Amazon DataZone catalog).
    listing_id: ?[]const u8,

    /// The revision of the listing (asset published in Amazon DataZone catalog).
    listing_revision: ?[]const u8,

    /// The Amazon DataZone user who updated the listing.
    listing_updated_by: ?[]const u8,

    /// The name of the inventory asset.
    name: ?[]const u8,

    /// The identifier of the project that owns the inventory asset.
    owning_project_id: ?[]const u8,

    pub const json_field_names = .{
        .additional_attributes = "additionalAttributes",
        .created_at = "createdAt",
        .description = "description",
        .entity_id = "entityId",
        .entity_revision = "entityRevision",
        .entity_type = "entityType",
        .glossary_terms = "glossaryTerms",
        .governed_glossary_terms = "governedGlossaryTerms",
        .listing_created_by = "listingCreatedBy",
        .listing_id = "listingId",
        .listing_revision = "listingRevision",
        .listing_updated_by = "listingUpdatedBy",
        .name = "name",
        .owning_project_id = "owningProjectId",
    };
};
