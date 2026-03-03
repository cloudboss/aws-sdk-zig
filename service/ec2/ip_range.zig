/// Describes an IPv4 address range.
pub const IpRange = struct {
    /// The IPv4 address range. You can either specify a CIDR block or a source
    /// security group,
    /// not both. To specify a single IPv4 address, use the /32 prefix length.
    ///
    /// Amazon Web Services
    /// [canonicalizes](https://en.wikipedia.org/wiki/Canonicalization) IPv4 and
    /// IPv6 CIDRs. For example, if you specify 100.68.0.18/18 for the CIDR block,
    /// Amazon Web Services canonicalizes the CIDR block to 100.68.0.0/18. Any
    /// subsequent DescribeSecurityGroups and DescribeSecurityGroupRules calls will
    /// return the canonicalized form of the CIDR block. Additionally, if you
    /// attempt to add another rule with the
    /// non-canonical form of the CIDR (such as 100.68.0.18/18) and there is already
    /// a rule for the canonicalized
    /// form of the CIDR block (such as 100.68.0.0/18), the API throws an duplicate
    /// rule error.
    cidr_ip: ?[]const u8 = null,

    /// A description for the security group rule that references this IPv4 address
    /// range.
    ///
    /// Constraints: Up to 255 characters in length. Allowed characters are a-z,
    /// A-Z, 0-9,
    /// spaces, and ._-:/()#,@[]+=&;{}!$*
    description: ?[]const u8 = null,
};
