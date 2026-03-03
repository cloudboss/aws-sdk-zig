const GlossaryItemAdditionalAttributes = @import("glossary_item_additional_attributes.zig").GlossaryItemAdditionalAttributes;
const GlossaryStatus = @import("glossary_status.zig").GlossaryStatus;
const GlossaryUsageRestriction = @import("glossary_usage_restriction.zig").GlossaryUsageRestriction;

/// The details of a business glossary.
pub const GlossaryItem = struct {
    /// The additional attributes of an Amazon DataZone glossary.
    additional_attributes: ?GlossaryItemAdditionalAttributes = null,

    /// The timestamp of when the glossary was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created the glossary.
    created_by: ?[]const u8 = null,

    /// The business glossary description.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain in which the business glossary
    /// exists.
    domain_id: []const u8,

    /// The identifier of the glossary.
    id: []const u8,

    /// The name of the glossary.
    name: []const u8,

    /// The identifier of the project that owns the business glosary.
    owning_project_id: []const u8,

    /// The business glossary status.
    status: GlossaryStatus,

    /// The timestamp of when the business glossary was updated.
    updated_at: ?i64 = null,

    /// The Amazon DataZone user who updated the business glossary.
    updated_by: ?[]const u8 = null,

    /// The usage restrictions associated with a goverened glossary term.
    usage_restrictions: ?[]const GlossaryUsageRestriction = null,

    pub const json_field_names = .{
        .additional_attributes = "additionalAttributes",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .id = "id",
        .name = "name",
        .owning_project_id = "owningProjectId",
        .status = "status",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .usage_restrictions = "usageRestrictions",
    };
};
