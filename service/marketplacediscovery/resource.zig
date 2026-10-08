const ResourceContentType = @import("resource_content_type.zig").ResourceContentType;
const ResourceType = @import("resource_type.zig").ResourceType;

/// A resource that provides supplementary information about a product, such as
/// documentation links, support contacts, or usage instructions.
pub const Resource = struct {
    /// The format of the resource content, such as a URL, email address, or text.
    content_type: ResourceContentType,

    /// An optional human-readable label for the resource.
    display_name: ?[]const u8 = null,

    /// The category of the resource, such as manufacturer support or usage
    /// instructions.
    resource_type: ResourceType,

    /// The resource content. Interpretation depends on the content type.
    value: []const u8,

    pub const json_field_names = .{
        .content_type = "contentType",
        .display_name = "displayName",
        .resource_type = "resourceType",
        .value = "value",
    };
};
