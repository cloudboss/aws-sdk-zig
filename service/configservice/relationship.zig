const ResourceType = @import("resource_type.zig").ResourceType;

/// The relationship of the related resource to the main
/// resource.
pub const Relationship = struct {
    /// The type of relationship with the related resource.
    relationship_name: ?[]const u8 = null,

    /// The ID of the related resource (for example,
    /// `sg-xxxxxx`).
    resource_id: ?[]const u8 = null,

    /// The custom name of the related resource, if
    /// available.
    resource_name: ?[]const u8 = null,

    /// The resource type of the related resource.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .relationship_name = "relationshipName",
        .resource_id = "resourceId",
        .resource_name = "resourceName",
        .resource_type = "resourceType",
    };
};
