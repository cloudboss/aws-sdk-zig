const InstanceSecondaryInterfaceAttachment = @import("instance_secondary_interface_attachment.zig").InstanceSecondaryInterfaceAttachment;
const SecondaryInterfaceType = @import("secondary_interface_type.zig").SecondaryInterfaceType;
const InstanceSecondaryInterfacePrivateIpAddress = @import("instance_secondary_interface_private_ip_address.zig").InstanceSecondaryInterfacePrivateIpAddress;
const SecondaryInterfaceStatus = @import("secondary_interface_status.zig").SecondaryInterfaceStatus;

/// Describes a secondary interface attached to an instance.
pub const InstanceSecondaryInterface = struct {
    /// The attachment information for the secondary interface.
    attachment: ?InstanceSecondaryInterfaceAttachment = null,

    /// The type of secondary interface.
    interface_type: ?SecondaryInterfaceType = null,

    /// The MAC address of the secondary interface.
    mac_address: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the owner of the secondary interface.
    owner_id: ?[]const u8 = null,

    /// The private IPv4 addresses associated with the secondary interface.
    private_ip_addresses: ?[]const InstanceSecondaryInterfacePrivateIpAddress = null,

    /// The ID of the secondary interface.
    secondary_interface_id: ?[]const u8 = null,

    /// The ID of the secondary network.
    secondary_network_id: ?[]const u8 = null,

    /// The ID of the secondary subnet.
    secondary_subnet_id: ?[]const u8 = null,

    /// Indicates whether source/destination checking is enabled.
    source_dest_check: ?bool = null,

    /// The status of the secondary interface.
    status: ?SecondaryInterfaceStatus = null,
};
