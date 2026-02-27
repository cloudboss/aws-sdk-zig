const IpAddressAssignment = @import("ip_address_assignment.zig").IpAddressAssignment;
const PhysicalConnectorType = @import("physical_connector_type.zig").PhysicalConnectorType;

/// The details about the physical network interface for the device.
pub const PhysicalNetworkInterface = struct {
    /// The default gateway of the device.
    default_gateway: ?[]const u8,

    /// The IP address of the device.
    ip_address: ?[]const u8,

    /// A value that describes whether the IP address is dynamic or persistent.
    ip_address_assignment: ?IpAddressAssignment,

    /// The MAC address of the device.
    mac_address: ?[]const u8,

    /// The netmask used to divide the IP address into subnets.
    netmask: ?[]const u8,

    /// The
    /// physical
    /// connector type.
    physical_connector_type: ?PhysicalConnectorType,

    /// The physical network interface ID.
    physical_network_interface_id: ?[]const u8,

    pub const json_field_names = .{
        .default_gateway = "defaultGateway",
        .ip_address = "ipAddress",
        .ip_address_assignment = "ipAddressAssignment",
        .mac_address = "macAddress",
        .netmask = "netmask",
        .physical_connector_type = "physicalConnectorType",
        .physical_network_interface_id = "physicalNetworkInterfaceId",
    };
};
