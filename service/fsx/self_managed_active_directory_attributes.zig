/// The configuration of the self-managed Microsoft Active Directory (AD)
/// directory to
/// which the Windows File Server or ONTAP storage virtual machine (SVM)
/// instance is joined.
pub const SelfManagedActiveDirectoryAttributes = struct {
    /// A list of up to three IP addresses of DNS servers or domain controllers in
    /// the
    /// self-managed AD directory.
    dns_ips: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Secrets Manager
    /// secret containing the service account credentials used to join the file
    /// system to your self-managed Active Directory domain.
    domain_join_service_account_secret: ?[]const u8,

    /// The fully qualified domain name of the self-managed AD directory.
    domain_name: ?[]const u8,

    /// The name of the domain group whose members have administrative privileges
    /// for the FSx
    /// file system.
    file_system_administrators_group: ?[]const u8,

    /// The fully qualified distinguished name of the organizational unit within the
    /// self-managed AD directory to which the Windows File Server or ONTAP storage
    /// virtual machine (SVM) instance is joined.
    organizational_unit_distinguished_name: ?[]const u8,

    /// The user name for the service account on your self-managed AD domain that
    /// FSx uses to
    /// join to your AD domain.
    user_name: ?[]const u8,

    pub const json_field_names = .{
        .dns_ips = "DnsIps",
        .domain_join_service_account_secret = "DomainJoinServiceAccountSecret",
        .domain_name = "DomainName",
        .file_system_administrators_group = "FileSystemAdministratorsGroup",
        .organizational_unit_distinguished_name = "OrganizationalUnitDistinguishedName",
        .user_name = "UserName",
    };
};
