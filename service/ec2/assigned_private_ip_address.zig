/// Describes the private IP addresses assigned to a network interface.
pub const AssignedPrivateIpAddress = struct {
    /// The private IP address assigned to the network interface.
    private_ip_address: ?[]const u8 = null,
};
