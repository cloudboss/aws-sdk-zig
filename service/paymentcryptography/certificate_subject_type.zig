/// The metadata used to create the certificate signing request.
pub const CertificateSubjectType = struct {
    /// The city you provide to create the certificate signing request.
    city: ?[]const u8 = null,

    /// The name you provide to create the certificate signing request.
    common_name: []const u8,

    /// The country you provide to create the certificate signing request.
    country: ?[]const u8 = null,

    /// The email address you provide to create the certificate signing request.
    email_address: ?[]const u8 = null,

    /// The organization you provide to create the certificate signing request.
    organization: ?[]const u8 = null,

    /// The organization unit you provide to create the certificate signing request.
    organization_unit: ?[]const u8 = null,

    /// The state or province you provide to create the certificate signing request.
    state_or_province: ?[]const u8 = null,

    pub const json_field_names = .{
        .city = "City",
        .common_name = "CommonName",
        .country = "Country",
        .email_address = "EmailAddress",
        .organization = "Organization",
        .organization_unit = "OrganizationUnit",
        .state_or_province = "StateOrProvince",
    };
};
