/// Describes the configuration information required to join fleets and image
/// builders to Microsoft Active Directory domains.
pub const DomainJoinInfo = struct {
    /// The fully qualified name of the directory (for example, corp.example.com).
    directory_name: ?[]const u8 = null,

    /// The distinguished name of the organizational unit for computer accounts.
    organizational_unit_distinguished_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .directory_name = "DirectoryName",
        .organizational_unit_distinguished_name = "OrganizationalUnitDistinguishedName",
    };
};
