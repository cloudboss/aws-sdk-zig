/// Information about an Active Directory domain membership record associated
/// with the DB
/// instance.
pub const AwsRdsDbDomainMembership = struct {
    /// The identifier of the Active Directory domain.
    domain: ?[]const u8 = null,

    /// The fully qualified domain name of the Active Directory domain.
    fqdn: ?[]const u8 = null,

    /// The name of the IAM role to use when making API calls to the Directory
    /// Service.
    iam_role_name: ?[]const u8 = null,

    /// The status of the Active Directory Domain membership for the DB instance.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain = "Domain",
        .fqdn = "Fqdn",
        .iam_role_name = "IamRoleName",
        .status = "Status",
    };
};
