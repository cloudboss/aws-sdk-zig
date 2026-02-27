const NetworkInterfaceMode = @import("network_interface_mode.zig").NetworkInterfaceMode;

/// A mapping that's used to pair a logical network interface name on a Node
/// with the physical interface name exposed in the operating system.
pub const NodeInterfaceMapping = struct {
    /// A uniform logical interface name to address in a MediaLive channel
    /// configuration.
    logical_interface_name: ?[]const u8,

    network_interface_mode: ?NetworkInterfaceMode,

    /// The IP addresses associated with the physical interface on the node
    /// hardware.
    physical_interface_ip_addresses: ?[]const []const u8,

    /// The name of the physical interface on the hardware that will be running
    /// Elemental anywhere.
    physical_interface_name: ?[]const u8,

    pub const json_field_names = .{
        .logical_interface_name = "LogicalInterfaceName",
        .network_interface_mode = "NetworkInterfaceMode",
        .physical_interface_ip_addresses = "PhysicalInterfaceIpAddresses",
        .physical_interface_name = "PhysicalInterfaceName",
    };
};
