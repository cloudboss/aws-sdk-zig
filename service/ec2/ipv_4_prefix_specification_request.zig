/// Describes the IPv4 prefix option for a network interface.
pub const Ipv4PrefixSpecificationRequest = struct {
    /// The IPv4 prefix. For information, see [
    /// Assigning prefixes to network
    /// interfaces](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-prefix-eni.html) in the
    /// *Amazon EC2 User Guide*.
    ipv_4_prefix: ?[]const u8 = null,
};
