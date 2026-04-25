const CustomAttribute = @import("custom_attribute.zig").CustomAttribute;

/// Contains X.500 distinguished name information.
pub const DistinguishedName = struct {
    /// The common name (CN) attribute.
    common_name: ?[]const u8 = null,

    /// The country (C) attribute.
    country: ?[]const u8 = null,

    /// A list of custom attributes in the distinguished name. Each custom attribute
    /// contains an object identifier (OID) and its corresponding value.
    custom_attributes: ?[]const CustomAttribute = null,

    /// The distinguished name qualifier attribute.
    distinguished_name_qualifier: ?[]const u8 = null,

    /// The domain component attributes.
    domain_components: ?[]const []const u8 = null,

    /// The generation qualifier attribute.
    generation_qualifier: ?[]const u8 = null,

    /// The given name attribute.
    given_name: ?[]const u8 = null,

    /// The initials attribute.
    initials: ?[]const u8 = null,

    /// The locality (L) attribute.
    locality: ?[]const u8 = null,

    /// The organization (O) attribute.
    organization: ?[]const u8 = null,

    /// The organizational unit (OU) attribute.
    organizational_unit: ?[]const u8 = null,

    /// The pseudonym attribute.
    pseudonym: ?[]const u8 = null,

    /// The serial number attribute.
    serial_number: ?[]const u8 = null,

    /// The state or province (ST) attribute.
    state: ?[]const u8 = null,

    /// The surname attribute.
    surname: ?[]const u8 = null,

    /// The title attribute.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .common_name = "CommonName",
        .country = "Country",
        .custom_attributes = "CustomAttributes",
        .distinguished_name_qualifier = "DistinguishedNameQualifier",
        .domain_components = "DomainComponents",
        .generation_qualifier = "GenerationQualifier",
        .given_name = "GivenName",
        .initials = "Initials",
        .locality = "Locality",
        .organization = "Organization",
        .organizational_unit = "OrganizationalUnit",
        .pseudonym = "Pseudonym",
        .serial_number = "SerialNumber",
        .state = "State",
        .surname = "Surname",
        .title = "Title",
    };
};
