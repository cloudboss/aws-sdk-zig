const SecondaryInterfaceType = @import("secondary_interface_type.zig").SecondaryInterfaceType;
const SecondaryInterfacePrivateIpAddressSpecification = @import("secondary_interface_private_ip_address_specification.zig").SecondaryInterfacePrivateIpAddressSpecification;

/// Describes a secondary interface specification in a launch template.
pub const LaunchTemplateInstanceSecondaryInterfaceSpecification = struct {
    /// Indicates whether the secondary interface is deleted when the instance is
    /// terminated.
    ///
    /// The only supported value for this field is `true`.
    delete_on_termination: ?bool = null,

    /// The device index for the secondary interface attachment.
    device_index: ?i32 = null,

    /// The type of secondary interface.
    interface_type: ?SecondaryInterfaceType = null,

    /// The index of the network card.
    network_card_index: ?i32 = null,

    /// The number of private IPv4 addresses to assign to the secondary interface.
    ///
    /// If you specify `privateIpAddressCount` you cannot specify
    /// `privateIpAddresses`
    private_ip_address_count: ?i32 = null,

    /// The private IPv4 addresses to assign to the secondary interface.
    ///
    /// If you specify `privateIpAddresses` you cannot specify
    /// `privateIpAddressCount`
    private_ip_addresses: ?[]const SecondaryInterfacePrivateIpAddressSpecification = null,

    /// The ID of the secondary subnet.
    secondary_subnet_id: ?[]const u8 = null,
};
