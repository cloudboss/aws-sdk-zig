const PortRangeConstraints = @import("port_range_constraints.zig").PortRangeConstraints;
const ServiceNodePortRange = @import("service_node_port_range.zig").ServiceNodePortRange;

/// A port range parameter configuration with default value and constraints.
pub const PortRangeParameterConfig = struct {
    /// The constraints for the port range parameter.
    constraints: ?PortRangeConstraints = null,

    /// The default port range value.
    default_value: ?ServiceNodePortRange = null,

    pub const json_field_names = .{
        .constraints = "constraints",
        .default_value = "defaultValue",
    };
};
