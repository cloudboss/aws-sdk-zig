const AssetItemAdditionalAttributes = @import("asset_item_additional_attributes.zig").AssetItemAdditionalAttributes;

/// A Amazon DataZone inventory asset.
pub const AssetItem = struct {
    /// The additional attributes of a Amazon DataZone inventory asset.
    additional_attributes: ?AssetItemAdditionalAttributes = null,

    /// The timestamp of when the Amazon DataZone inventory asset was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created the inventory asset.
    created_by: ?[]const u8 = null,

    /// The description of an Amazon DataZone inventory asset.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain in which the inventory asset
    /// exists.
    domain_id: []const u8,

    /// The external identifier of the Amazon DataZone inventory asset.
    external_identifier: ?[]const u8 = null,

    /// The timestamp of when the first revision of the inventory asset was created.
    first_revision_created_at: ?i64 = null,

    /// The Amazon DataZone user who created the first revision of the inventory
    /// asset.
    first_revision_created_by: ?[]const u8 = null,

    /// The glossary terms attached to the Amazon DataZone inventory asset.
    glossary_terms: ?[]const []const u8 = null,

    /// The restricted glossary terms accociated with an asset.
    governed_glossary_terms: ?[]const []const u8 = null,

    /// the identifier of the Amazon DataZone inventory asset.
    identifier: []const u8,

    /// The name of the Amazon DataZone inventory asset.
    name: []const u8,

    /// The identifier of the Amazon DataZone project that owns the inventory asset.
    owning_project_id: []const u8,

    /// The identifier of the asset type of the specified Amazon DataZone inventory
    /// asset.
    type_identifier: []const u8,

    /// The revision of the inventory asset type.
    type_revision: []const u8,

    pub const json_field_names = .{
        .additional_attributes = "additionalAttributes",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .external_identifier = "externalIdentifier",
        .first_revision_created_at = "firstRevisionCreatedAt",
        .first_revision_created_by = "firstRevisionCreatedBy",
        .glossary_terms = "glossaryTerms",
        .governed_glossary_terms = "governedGlossaryTerms",
        .identifier = "identifier",
        .name = "name",
        .owning_project_id = "owningProjectId",
        .type_identifier = "typeIdentifier",
        .type_revision = "typeRevision",
    };
};
