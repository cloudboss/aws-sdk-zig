const IpAddressAssignment = @import("ip_address_assignment.zig").IpAddressAssignment;
const PhysicalConnectorType = @import("physical_connector_type.zig").PhysicalConnectorType;

/// The details about the physical network interface for the device.
pub const PhysicalNetworkInterface = struct {
    /// The default gateway of the device.
    default_gateway: ?[]const u8 = null,

    /// The IP address of the device.
    ip_address: ?[]const u8 = null,

    /// A value that describes whether the IP address is dynamic or persistent.
    ip_address_assignment: ?IpAddressAssignment = null,

    /// The MAC address of the device.
    mac_address: ?[]const u8 = null,

    /// The netmask used to divide the IP address into subnets.
    netmask: ?[]const u8 = null,

    /// The
    /// physical
    /// connector type.
    physical_connector_type: ?PhysicalConnectorType = null,

    /// The physical network interface ID.
    physical_network_interface_id: ?[]const u8 = null,

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
