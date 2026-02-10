/// Provides authorization for Amazon to bring a specific IP address range to a
/// specific
/// Amazon Web Services account using bring your own IP addresses (BYOIP). For
/// more information, see [Configuring your BYOIP address
/// range](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-byoip.html#prepare-for-byoip) in the *Amazon EC2 User Guide*.
pub const CidrAuthorizationContext = struct {
    /// The plain-text authorization message for the prefix and account.
    message: []const u8,

    /// The signed authorization message for the prefix and account.
    signature: []const u8,
};
