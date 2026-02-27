const SimulationAppPortMapping = @import("simulation_app_port_mapping.zig").SimulationAppPortMapping;

/// Information about the network endpoint that you can use to connect to your
/// custom or
/// service app. For more information about SimSpace Weaver apps, see [Key
/// concepts:
/// Apps](https://docs.aws.amazon.com/simspaceweaver/latest/userguide/what-is_key-concepts.html#what-is_key-concepts_apps)
/// in the *SimSpace Weaver User Guide*..
pub const SimulationAppEndpointInfo = struct {
    /// The IP address of the app. SimSpace Weaver dynamically assigns this IP
    /// address when the
    /// app starts.
    address: ?[]const u8,

    /// The inbound TCP/UDP port numbers of the app. The combination of an IP
    /// address and
    /// a port number form a network endpoint.
    ingress_port_mappings: ?[]const SimulationAppPortMapping,

    pub const json_field_names = .{
        .address = "Address",
        .ingress_port_mappings = "IngressPortMappings",
    };
};
