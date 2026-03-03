const Resource = @import("resource.zig").Resource;

/// Information about a resource definition version.
pub const ResourceDefinitionVersion = struct {
    /// A list of resources.
    resources: ?[]const Resource = null,

    pub const json_field_names = .{
        .resources = "Resources",
    };
};
