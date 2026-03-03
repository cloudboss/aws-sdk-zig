const NetworkInterfaceMode = @import("network_interface_mode.zig").NetworkInterfaceMode;

/// Used in CreateNodeRequest.
pub const NodeInterfaceMappingCreateRequest = struct {
    /// Specify one of the logicalInterfaceNames that you created in the Cluster
    /// that this node belongs to. For example, my-Inputs-Interface.
    logical_interface_name: ?[]const u8 = null,

    /// The style of the network -- NAT or BRIDGE.
    network_interface_mode: ?NetworkInterfaceMode = null,

    /// Specify the physical name that corresponds to the logicalInterfaceName that
    /// you specified in this interface mapping. For example, Eth1 or
    /// ENO1234EXAMPLE.
    physical_interface_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .logical_interface_name = "LogicalInterfaceName",
        .network_interface_mode = "NetworkInterfaceMode",
        .physical_interface_name = "PhysicalInterfaceName",
    };
};
