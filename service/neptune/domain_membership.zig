/// An Active Directory Domain membership record associated with a DB instance.
pub const DomainMembership = struct {
    /// The identifier of the Active Directory Domain.
    domain: ?[]const u8 = null,

    /// The fully qualified domain name of the Active Directory Domain.
    fqdn: ?[]const u8 = null,

    /// The name of the IAM role to be used when making API calls to the Directory
    /// Service.
    iam_role_name: ?[]const u8 = null,

    /// The status of the DB instance's Active Directory Domain membership, such as
    /// joined,
    /// pending-join, failed etc).
    status: ?[]const u8 = null,
};
