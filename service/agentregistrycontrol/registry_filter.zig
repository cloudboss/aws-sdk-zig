const RegistryFilterName = @import("registry_filter_name.zig").RegistryFilterName;

/// A single filter applied to a ListRegistries request.
pub const RegistryFilter = struct {
    /// The attribute to filter on
    name: RegistryFilterName,

    /// The values to match for the attribute
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
