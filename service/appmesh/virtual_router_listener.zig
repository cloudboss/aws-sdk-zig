const PortMapping = @import("port_mapping.zig").PortMapping;

/// An object that represents a virtual router listener.
pub const VirtualRouterListener = struct {
    port_mapping: PortMapping,

    pub const json_field_names = .{
        .port_mapping = "portMapping",
    };
};
