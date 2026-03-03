const ResourceType = @import("resource_type.zig").ResourceType;

/// The URIs for function resources.
pub const ResourceUri = struct {
    /// The type of the resource.
    resource_type: ?ResourceType = null,

    /// The URI for accessing the resource.
    uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_type = "ResourceType",
        .uri = "Uri",
    };
};
