const RouterNetworkInterfaceType = @import("router_network_interface_type.zig").RouterNetworkInterfaceType;

/// A filter that can be used to retrieve a list of router network interfaces.
pub const RouterNetworkInterfaceFilter = union(enum) {
    /// The names of the router network interfaces to include in the filter.
    name_contains: ?[]const []const u8,
    /// The types of router network interfaces to include in the filter.
    network_interface_types: ?[]const RouterNetworkInterfaceType,
    /// The AWS Regions of the router network interfaces to include in the filter.
    region_names: ?[]const []const u8,

    pub const json_field_names = .{
        .name_contains = "NameContains",
        .network_interface_types = "NetworkInterfaceTypes",
        .region_names = "RegionNames",
    };
};
