const aws = @import("aws");

const Method = @import("method.zig").Method;

/// Represents an API resource.
pub const Resource = struct {
    /// The resource's identifier.
    id: ?[]const u8,

    /// The parent resource's identifier.
    parent_id: ?[]const u8,

    /// The full path for this resource.
    path: ?[]const u8,

    /// The last path segment for this resource.
    path_part: ?[]const u8,

    /// Gets an API resource's method of a given HTTP verb.
    resource_methods: ?[]const aws.map.MapEntry(Method),

    pub const json_field_names = .{
        .id = "id",
        .parent_id = "parentId",
        .path = "path",
        .path_part = "pathPart",
        .resource_methods = "resourceMethods",
    };
};
