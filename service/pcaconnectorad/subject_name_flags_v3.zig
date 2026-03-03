/// Information to include in the subject name and alternate subject name of the
/// certificate. The subject name can be common name, directory path, DNS as
/// common name, or
/// left blank. You can optionally include email to the subject name for user
/// templates. If you
/// leave the subject name blank then you must set a subject alternate name. The
/// subject
/// alternate name (SAN) can include globally unique identifier (GUID), DNS,
/// domain DNS, email,
/// service principal name (SPN), and user principal name (UPN). You can leave
/// the SAN blank.
/// If you leave the SAN blank, then you must set a subject name.
pub const SubjectNameFlagsV3 = struct {
    /// Include the common name in the subject name.
    require_common_name: ?bool = null,

    /// Include the directory path in the subject name.
    require_directory_path: ?bool = null,

    /// Include the DNS as common name in the subject name.
    require_dns_as_cn: ?bool = null,

    /// Include the subject's email in the subject name.
    require_email: ?bool = null,

    /// Include the globally unique identifier (GUID) in the subject alternate name.
    san_require_directory_guid: ?bool = null,

    /// Include the DNS in the subject alternate name.
    san_require_dns: ?bool = null,

    /// Include the domain DNS in the subject alternate name.
    san_require_domain_dns: ?bool = null,

    /// Include the subject's email in the subject alternate name.
    san_require_email: ?bool = null,

    /// Include the service principal name (SPN) in the subject alternate name.
    san_require_spn: ?bool = null,

    /// Include the user principal name (UPN) in the subject alternate name.
    san_require_upn: ?bool = null,

    pub const json_field_names = .{
        .require_common_name = "RequireCommonName",
        .require_directory_path = "RequireDirectoryPath",
        .require_dns_as_cn = "RequireDnsAsCn",
        .require_email = "RequireEmail",
        .san_require_directory_guid = "SanRequireDirectoryGuid",
        .san_require_dns = "SanRequireDns",
        .san_require_domain_dns = "SanRequireDomainDns",
        .san_require_email = "SanRequireEmail",
        .san_require_spn = "SanRequireSpn",
        .san_require_upn = "SanRequireUpn",
    };
};
