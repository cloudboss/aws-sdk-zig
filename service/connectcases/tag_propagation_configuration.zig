const aws = @import("aws");

const TagPropagationResourceType = @import("tag_propagation_resource_type.zig").TagPropagationResourceType;

/// Defines tag propagation configuration for resources created within a domain.
/// Tags specified here will be automatically applied to resources being created
/// for the specified resource type.
pub const TagPropagationConfiguration = struct {
    /// Supported resource types for tag propagation. Determines which resources
    /// will receive automatically propagated tags.
    resource_type: TagPropagationResourceType,

    /// The tags that will be applied to the created resource.
    tag_map: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_type = "resourceType",
        .tag_map = "tagMap",
    };
};
