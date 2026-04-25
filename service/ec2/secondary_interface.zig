const SecondaryInterfaceAttachment = @import("secondary_interface_attachment.zig").SecondaryInterfaceAttachment;
const SecondaryInterfaceIpv4Address = @import("secondary_interface_ipv_4_address.zig").SecondaryInterfaceIpv4Address;
const SecondaryInterfaceType = @import("secondary_interface_type.zig").SecondaryInterfaceType;
const SecondaryNetworkType = @import("secondary_network_type.zig").SecondaryNetworkType;
const SecondaryInterfaceStatus = @import("secondary_interface_status.zig").SecondaryInterfaceStatus;
const Tag = @import("tag.zig").Tag;

/// Describes a secondary interface.
pub const SecondaryInterface = struct {
    /// The attachment information for the secondary interface.
    attachment: ?SecondaryInterfaceAttachment = null,

    /// The Availability Zone of the secondary interface.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone of the secondary interface.
    availability_zone_id: ?[]const u8 = null,

    /// The MAC address of the secondary interface.
    mac_address: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the secondary interface.
    owner_id: ?[]const u8 = null,

    /// The private IPv4 addresses associated with the secondary interface.
    private_ipv_4_addresses: ?[]const SecondaryInterfaceIpv4Address = null,

    /// The Amazon Resource Name (ARN) of the secondary interface.
    secondary_interface_arn: ?[]const u8 = null,

    /// The ID of the secondary interface.
    secondary_interface_id: ?[]const u8 = null,

    /// The type of secondary interface.
    secondary_interface_type: ?SecondaryInterfaceType = null,

    /// The ID of the secondary network.
    secondary_network_id: ?[]const u8 = null,

    /// The type of the secondary network.
    secondary_network_type: ?SecondaryNetworkType = null,

    /// The ID of the secondary subnet.
    secondary_subnet_id: ?[]const u8 = null,

    /// Indicates whether source/destination checking is enabled.
    source_dest_check: ?bool = null,

    /// The status of the secondary interface.
    status: ?SecondaryInterfaceStatus = null,

    /// The tags assigned to the secondary interface.
    tags: ?[]const Tag = null,
};
