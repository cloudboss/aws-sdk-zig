const IPAddressType = @import("ip_address_type.zig").IPAddressType;

/// High-level information about an Availability Zone where the firewall has an
/// endpoint defined.
pub const AvailabilityZoneMetadata = struct {
    /// The IP address type of the Firewall subnet in the Availability Zone. You
    /// can't change the IP address type after you create the subnet.
    ip_address_type: ?IPAddressType = null,

    pub const json_field_names = .{
        .ip_address_type = "IPAddressType",
    };
};
