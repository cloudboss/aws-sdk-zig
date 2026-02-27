const ResourceFilterName = @import("resource_filter_name.zig").ResourceFilterName;

/// A filter name and value pair that is used to obtain more specific results
/// from a list
/// of resources.
pub const ResourceFilter = struct {
    /// The name of the filter. Filter names are case-sensitive.
    name: ResourceFilterName,

    /// One or more filter values. Allowed filter values vary by resource filter
    /// name, and are
    /// case-sensitive.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
