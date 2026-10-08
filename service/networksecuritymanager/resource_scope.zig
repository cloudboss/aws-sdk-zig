const ResourceSet = @import("resource_set.zig").ResourceSet;

/// Defines which resources of a given type are in scope. Exactly one of
/// `includeAll`, `include`, or `exclude` is set.
pub const ResourceScope = struct {
    /// Excludes the resources that match the specified criteria or explicit ARNs.
    exclude: ?ResourceSet = null,

    /// Includes the resources that match the specified criteria or explicit ARNs.
    include: ?ResourceSet = null,

    /// Includes all resources of the resource type.
    include_all: ?bool = null,

    pub const json_field_names = .{
        .exclude = "exclude",
        .include = "include",
        .include_all = "includeAll",
    };
};
