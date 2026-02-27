/// An Active Directory Domain membership record associated with the DB instance
/// or cluster.
pub const DomainMembership = struct {
    /// The ARN for the Secrets Manager secret with the credentials for the user
    /// that's a member of the domain.
    auth_secret_arn: ?[]const u8,

    /// The IPv4 DNS IP addresses of the primary and secondary Active Directory
    /// domain controllers.
    dns_ips: ?[]const []const u8,

    /// The identifier of the Active Directory Domain.
    domain: ?[]const u8,

    /// The fully qualified domain name (FQDN) of the Active Directory Domain.
    fqdn: ?[]const u8,

    /// The name of the IAM role used when making API calls to the Directory
    /// Service.
    iam_role_name: ?[]const u8,

    /// The Active Directory organizational unit for the DB instance or cluster.
    ou: ?[]const u8,

    /// The status of the Active Directory Domain membership for the DB instance or
    /// cluster. Values include `joined`, `pending-join`, `failed`, and so on.
    status: ?[]const u8,
};
