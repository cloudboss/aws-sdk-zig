const CustomAttribute = @import("custom_attribute.zig").CustomAttribute;

/// Contains information about the certificate subject. The `Subject` field in
/// the certificate identifies the entity that owns or controls the public key
/// in the certificate. The entity can be a user, computer, device, or service.
/// The `Subject `must contain an X.500 distinguished name (DN). A DN is a
/// sequence of relative distinguished names (RDNs). The RDNs are separated by
/// commas in the certificate.
pub const ASN1Subject = struct {
    /// For CA and end-entity certificates in a private PKI, the common name (CN)
    /// can be any string within the length limit.
    ///
    /// Note: In publicly trusted certificates, the common name must be a fully
    /// qualified domain name (FQDN) associated with the certificate subject.
    common_name: ?[]const u8 = null,

    /// Two-digit code that specifies the country in which the certificate subject
    /// located.
    country: ?[]const u8 = null,

    /// Contains a sequence of one or more X.500 relative distinguished names
    /// (RDNs), each of which consists of an object identifier (OID) and a value.
    /// For more information, see NIST’s definition of [Object Identifier
    /// (OID)](https://csrc.nist.gov/glossary/term/Object_Identifier).
    ///
    /// Custom attributes cannot be used in combination with standard attributes.
    custom_attributes: ?[]const CustomAttribute = null,

    /// Disambiguating information for the certificate subject.
    distinguished_name_qualifier: ?[]const u8 = null,

    /// Typically a qualifier appended to the name of an individual. Examples
    /// include Jr. for junior, Sr. for senior, and III for third.
    generation_qualifier: ?[]const u8 = null,

    /// First name.
    given_name: ?[]const u8 = null,

    /// Concatenation that typically contains the first letter of the **GivenName**,
    /// the first letter of the middle name if one exists, and the first letter of
    /// the **Surname**.
    initials: ?[]const u8 = null,

    /// The locality (such as a city or town) in which the certificate subject is
    /// located.
    locality: ?[]const u8 = null,

    /// Legal name of the organization with which the certificate subject is
    /// affiliated.
    organization: ?[]const u8 = null,

    /// A subdivision or unit of the organization (such as sales or finance) with
    /// which the certificate subject is affiliated.
    organizational_unit: ?[]const u8 = null,

    /// Typically a shortened version of a longer **GivenName**. For example,
    /// Jonathan is often shortened to John. Elizabeth is often shortened to Beth,
    /// Liz, or Eliza.
    pseudonym: ?[]const u8 = null,

    /// The certificate serial number.
    serial_number: ?[]const u8 = null,

    /// State in which the subject of the certificate is located.
    state: ?[]const u8 = null,

    /// Family name. In the US and the UK, for example, the surname of an individual
    /// is ordered last. In Asian cultures the surname is typically ordered first.
    surname: ?[]const u8 = null,

    /// A title such as Mr. or Ms., which is pre-pended to the name to refer
    /// formally to the certificate subject.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .common_name = "CommonName",
        .country = "Country",
        .custom_attributes = "CustomAttributes",
        .distinguished_name_qualifier = "DistinguishedNameQualifier",
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
