/// Describes an IPv4 prefix.
pub const Ipv4PrefixSpecification = struct {
    /// The IPv4 prefix. For information, see [
    /// Assigning prefixes to network
    /// interfaces](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-prefix-eni.html) in the
    /// *Amazon EC2 User Guide*.
    ipv_4_prefix: ?[]const u8,
};
