/// A list of IP address ranges
/// ([CIDRs](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html)). Used to create an allow list of IP addresses for a private workforce. Workers will only be able to log in to their worker portal from an IP address within this range. By default, a workforce isn't restricted to specific IP addresses.
pub const SourceIpConfig = struct {
    /// A list of one to ten [Classless Inter-Domain
    /// Routing](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html)
    /// (CIDR) values.
    ///
    /// Maximum: Ten CIDR values
    ///
    /// The following Length Constraints apply to individual CIDR values in the CIDR
    /// value list.
    cidrs: []const []const u8,

    pub const json_field_names = .{
        .cidrs = "Cidrs",
    };
};
