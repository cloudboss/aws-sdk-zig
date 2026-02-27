const ResourcePathComponent = @import("resource_path_component.zig").ResourcePathComponent;

/// Describes the path information of a resource.
pub const ResourcePath = struct {
    /// The components of the resource path.
    components: ?[]const ResourcePathComponent,

    pub const json_field_names = .{
        .components = "Components",
    };
};
