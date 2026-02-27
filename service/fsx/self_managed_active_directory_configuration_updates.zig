/// Specifies changes you are making to the self-managed Microsoft Active
/// Directory configuration to which
/// an FSx for Windows File Server file system or an FSx for ONTAP SVM is
/// joined.
pub const SelfManagedActiveDirectoryConfigurationUpdates = struct {
    /// A list of up to three DNS server or domain controller IP addresses in your
    /// self-managed Active Directory domain.
    dns_ips: ?[]const []const u8,

    /// Specifies the updated Amazon Resource Name (ARN) of the Amazon Web Services
    /// Secrets Manager secret containing the self-managed Active Directory domain
    /// join service account credentials.
    /// Amazon FSx uses this account to join to your self-managed Active Directory
    /// domain.
    domain_join_service_account_secret: ?[]const u8,

    /// Specifies an updated fully qualified domain name of your self-managed Active
    /// Directory configuration.
    domain_name: ?[]const u8,

    /// For FSx for ONTAP file systems only - Specifies the updated name of the
    /// self-managed Active Directory domain group whose members are granted
    /// administrative privileges
    /// for the Amazon FSx resource.
    file_system_administrators_group: ?[]const u8,

    /// Specifies an updated fully qualified distinguished name of the organization
    /// unit within your self-managed Active Directory.
    organizational_unit_distinguished_name: ?[]const u8,

    /// Specifies the updated password for the service account on your self-managed
    /// Active Directory domain.
    /// Amazon FSx uses this account to join to your self-managed Active Directory
    /// domain.
    password: ?[]const u8,

    /// Specifies the updated user name for the service account on your self-managed
    /// Active Directory domain.
    /// Amazon FSx uses this account to join to your self-managed Active Directory
    /// domain.
    ///
    /// This account must have the permissions required to join
    /// computers to the domain in the organizational unit provided in
    /// `OrganizationalUnitDistinguishedName`.
    user_name: ?[]const u8,

    pub const json_field_names = .{
        .dns_ips = "DnsIps",
        .domain_join_service_account_secret = "DomainJoinServiceAccountSecret",
        .domain_name = "DomainName",
        .file_system_administrators_group = "FileSystemAdministratorsGroup",
        .organizational_unit_distinguished_name = "OrganizationalUnitDistinguishedName",
        .password = "Password",
        .user_name = "UserName",
    };
};
