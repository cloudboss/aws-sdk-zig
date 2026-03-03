const DataProductItemAdditionalAttributes = @import("data_product_item_additional_attributes.zig").DataProductItemAdditionalAttributes;

/// The data product.
pub const DataProductResultItem = struct {
    /// The additional attributes of an Amazon DataZone data product.
    additional_attributes: ?DataProductItemAdditionalAttributes = null,

    /// The timestamp at which the data product was created.
    created_at: ?i64 = null,

    /// The user who created the data product.
    created_by: ?[]const u8 = null,

    /// The description of the data product.
    description: ?[]const u8 = null,

    /// The ID of the domain where the data product lives.
    domain_id: []const u8,

    /// The timestamp at which first revision of the data product was created.
    first_revision_created_at: ?i64 = null,

    /// The user who created the first revision of the data product.
    first_revision_created_by: ?[]const u8 = null,

    /// The glossary terms of the data product.
    glossary_terms: ?[]const []const u8 = null,

    /// The ID of the data product.
    id: []const u8,

    /// The name of the data product.
    name: []const u8,

    /// The ID of the owning project of the data product.
    owning_project_id: []const u8,

    pub const json_field_names = .{
        .additional_attributes = "additionalAttributes",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .first_revision_created_at = "firstRevisionCreatedAt",
        .first_revision_created_by = "firstRevisionCreatedBy",
        .glossary_terms = "glossaryTerms",
        .id = "id",
        .name = "name",
        .owning_project_id = "owningProjectId",
    };
};
