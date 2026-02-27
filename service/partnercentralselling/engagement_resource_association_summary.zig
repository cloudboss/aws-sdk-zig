const ResourceType = @import("resource_type.zig").ResourceType;

/// This provide a streamlined view of the relationships between engagements and
/// resources. These summaries offer a crucial link between collaborative
/// engagements and the specific resources involved, such as opportunities.These
/// summaries are particularly valuable for partners navigating complex
/// engagements with multiple resources. They enable quick insights into
/// resource distribution across engagements, support efficient resource
/// management, and help maintain a clear overview of collaborative activities.
pub const EngagementResourceAssociationSummary = struct {
    /// Indicates the environment in which the resource and engagement exist.
    catalog: []const u8,

    /// The AWS account ID of the entity that owns the resource. Identifies the
    /// account responsible for or having primary control over the resource.
    created_by: ?[]const u8,

    /// A unique identifier for the engagement associated with the resource.
    engagement_id: ?[]const u8,

    /// A unique identifier for the specific resource. Varies depending on the
    /// resource type.
    resource_id: ?[]const u8,

    /// Categorizes the type of resource associated with the engagement.
    resource_type: ?ResourceType,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .created_by = "CreatedBy",
        .engagement_id = "EngagementId",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};
