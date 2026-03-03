/// Describes a private IPv4 address for a Scheduled Instance.
pub const ScheduledInstancesPrivateIpAddressConfig = struct {
    /// Indicates whether this is a primary IPv4 address. Otherwise, this is a
    /// secondary IPv4 address.
    primary: ?bool = null,

    /// The IPv4 address.
    private_ip_address: ?[]const u8 = null,
};
