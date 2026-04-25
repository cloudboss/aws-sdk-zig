const ExtendedKeyUsageName = @import("extended_key_usage_name.zig").ExtendedKeyUsageName;
const DistinguishedName = @import("distinguished_name.zig").DistinguishedName;
const KeyAlgorithm = @import("key_algorithm.zig").KeyAlgorithm;
const KeyUsageName = @import("key_usage_name.zig").KeyUsageName;
const GeneralName = @import("general_name.zig").GeneralName;

/// Contains X.509 certificate attributes extracted from the certificate.
pub const X509Attributes = struct {
    /// Contains a list of Extended Key Usage X.509 v3 extension objects. Each
    /// object specifies a purpose for which the certificate public key can be used
    /// and consists of a name and an object identifier (OID).
    extended_key_usages: ?[]const ExtendedKeyUsageName = null,

    /// The distinguished name of the certificate issuer.
    issuer: ?DistinguishedName = null,

    /// The algorithm that was used to generate the public-private key pair.
    key_algorithm: ?KeyAlgorithm = null,

    /// A list of Key Usage X.509 v3 extension objects. Each object is a string
    /// value that identifies the purpose of the public key contained in the
    /// certificate. Possible extension values include DIGITAL_SIGNATURE,
    /// KEY_ENCHIPHERMENT, NON_REPUDIATION, and more.
    key_usages: ?[]const KeyUsageName = null,

    /// The time after which the certificate is not valid.
    not_after: ?i64 = null,

    /// The time before which the certificate is not valid.
    not_before: ?i64 = null,

    /// The serial number assigned by the certificate authority.
    serial_number: ?[]const u8 = null,

    /// The distinguished name of the certificate subject.
    subject: ?DistinguishedName = null,

    /// One or more domain names (subject alternative names) included in the
    /// certificate. This list contains the domain names that are bound to the
    /// public key that is contained in the certificate. The subject alternative
    /// names include the canonical domain name (CN) of the certificate and
    /// additional domain names that can be used to connect to the website.
    subject_alternative_names: ?[]const GeneralName = null,

    pub const json_field_names = .{
        .extended_key_usages = "ExtendedKeyUsages",
        .issuer = "Issuer",
        .key_algorithm = "KeyAlgorithm",
        .key_usages = "KeyUsages",
        .not_after = "NotAfter",
        .not_before = "NotBefore",
        .serial_number = "SerialNumber",
        .subject = "Subject",
        .subject_alternative_names = "SubjectAlternativeNames",
    };
};
