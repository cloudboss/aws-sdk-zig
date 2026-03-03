const GlossaryTermItemAdditionalAttributes = @import("glossary_term_item_additional_attributes.zig").GlossaryTermItemAdditionalAttributes;
const GlossaryTermStatus = @import("glossary_term_status.zig").GlossaryTermStatus;
const TermRelations = @import("term_relations.zig").TermRelations;
const GlossaryUsageRestriction = @import("glossary_usage_restriction.zig").GlossaryUsageRestriction;

/// The details of a business glossary term.
pub const GlossaryTermItem = struct {
    /// The additional attributes of an Amazon DataZone glossary term.
    additional_attributes: ?GlossaryTermItemAdditionalAttributes = null,

    /// The timestamp of when a business glossary term was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created the business glossary.
    created_by: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain in which the business glossary
    /// exists.
    domain_id: []const u8,

    /// The identifier of the business glossary to which the term belongs.
    glossary_id: []const u8,

    /// The identifier of the business glossary term.
    id: []const u8,

    /// The long description of the business glossary term.
    long_description: ?[]const u8 = null,

    /// The name of the business glossary term.
    name: []const u8,

    /// The short description of the business glossary term.
    short_description: ?[]const u8 = null,

    /// The status of the business glossary term.
    status: GlossaryTermStatus,

    /// The relations of the business glossary term.
    term_relations: ?TermRelations = null,

    /// The timestamp of when a business glossary term was updated.
    updated_at: ?i64 = null,

    /// The Amazon DataZone user who updated the business glossary term.
    updated_by: ?[]const u8 = null,

    /// The usage restrictions associated with a goverened glossary term.
    usage_restrictions: ?[]const GlossaryUsageRestriction = null,

    pub const json_field_names = .{
        .additional_attributes = "additionalAttributes",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .glossary_id = "glossaryId",
        .id = "id",
        .long_description = "longDescription",
        .name = "name",
        .short_description = "shortDescription",
        .status = "status",
        .term_relations = "termRelations",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .usage_restrictions = "usageRestrictions",
    };
};
