/// The configuration that Amazon FSx uses to join a FSx for Windows File Server
/// file system or an FSx for ONTAP storage virtual machine (SVM) to
/// a self-managed (including on-premises) Microsoft Active Directory (AD)
/// directory. For more information, see
/// [
/// Using Amazon FSx for Windows with your self-managed Microsoft Active
/// Directory](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/self-managed-AD.html) or
/// [Managing FSx for ONTAP
/// SVMs](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/managing-svms.html).
pub const SelfManagedActiveDirectoryConfiguration = struct {
    /// A list of up to three IP addresses of DNS servers or domain controllers in
    /// the
    /// self-managed AD directory.
    dns_ips: []const []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Secrets Manager
    /// secret containing the self-managed Active Directory domain join service
    /// account credentials.
    /// When provided, Amazon FSx uses the credentials stored in this secret to join
    /// the file system to your self-managed Active Directory domain.
    ///
    /// The secret must contain two key-value pairs:
    ///
    /// * `CUSTOMER_MANAGED_ACTIVE_DIRECTORY_USERNAME` - The username for the
    ///   service account
    ///
    /// * `CUSTOMER_MANAGED_ACTIVE_DIRECTORY_PASSWORD` - The password for the
    ///   service account
    ///
    /// For more information, see
    /// [
    /// Using Amazon FSx for Windows with your self-managed Microsoft Active
    /// Directory](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/self-manage-prereqs.html) or
    /// [
    /// Using Amazon FSx for ONTAP with your self-managed Microsoft Active
    /// Directory](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/self-manage-prereqs.html).
    domain_join_service_account_secret: ?[]const u8 = null,

    /// The fully qualified domain name of the self-managed AD directory, such as
    /// `corp.example.com`.
    domain_name: []const u8,

    /// (Optional) The name of the domain group whose members are granted
    /// administrative
    /// privileges for the file system. Administrative privileges include taking
    /// ownership of
    /// files and folders, setting audit controls (audit ACLs) on files and folders,
    /// and
    /// administering the file system remotely by using the FSx Remote PowerShell.
    /// The group that you specify must already exist in your domain. If you don't
    /// provide one,
    /// your AD domain's Domain Admins group is used.
    file_system_administrators_group: ?[]const u8 = null,

    /// (Optional) The fully qualified distinguished name of the organizational unit
    /// within
    /// your self-managed AD directory. Amazon
    /// FSx only accepts OU as the direct parent of the file system. An example is
    /// `OU=FSx,DC=yourdomain,DC=corp,DC=com`. To learn more, see [RFC
    /// 2253](https://tools.ietf.org/html/rfc2253). If none is provided, the
    /// FSx file system is created in the default location of your self-managed AD
    /// directory.
    ///
    /// Only Organizational Unit (OU) objects can be the direct parent of the file
    /// system
    /// that you're creating.
    organizational_unit_distinguished_name: ?[]const u8 = null,

    /// The password for the service account on your self-managed AD domain that
    /// Amazon FSx
    /// will use to join to your AD domain.
    password: ?[]const u8 = null,

    /// The user name for the service account on your self-managed AD domain that
    /// Amazon FSx
    /// will use to join to your AD domain. This account must have the permission to
    /// join
    /// computers to the domain in the organizational unit provided in
    /// `OrganizationalUnitDistinguishedName`, or in the default location of your
    /// AD domain.
    user_name: ?[]const u8 = null,

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
