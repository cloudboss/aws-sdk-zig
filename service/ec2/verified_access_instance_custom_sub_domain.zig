/// Describes a custom subdomain for a network CIDR endpoint for Verified
/// Access.
pub const VerifiedAccessInstanceCustomSubDomain = struct {
    /// The name servers.
    nameservers: ?[]const []const u8,

    /// The subdomain.
    sub_domain: ?[]const u8,
};
