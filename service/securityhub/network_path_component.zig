const NetworkHeader = @import("network_header.zig").NetworkHeader;

/// Information about a network path component.
pub const NetworkPathComponent = struct {
    /// The identifier of a component in the network path.
    ///
    /// Length Constraints: Minimum of 1. Maximum of 32.
    component_id: ?[]const u8,

    /// The type of component.
    ///
    /// Length Constraints: Minimum of 1. Maximum of 32.
    component_type: ?[]const u8,

    /// Information about the component that comes after the current component in
    /// the network
    /// path.
    egress: ?NetworkHeader,

    /// Information about the component that comes before the current node in the
    /// network
    /// path.
    ingress: ?NetworkHeader,

    pub const json_field_names = .{
        .component_id = "ComponentId",
        .component_type = "ComponentType",
        .egress = "Egress",
        .ingress = "Ingress",
    };
};
