const PolicyInformation = @import("policy_information.zig").PolicyInformation;
const CustomExtension = @import("custom_extension.zig").CustomExtension;
const ExtendedKeyUsage = @import("extended_key_usage.zig").ExtendedKeyUsage;
const KeyUsage = @import("key_usage.zig").KeyUsage;
const GeneralName = @import("general_name.zig").GeneralName;

/// Contains X.509 extension information for a certificate.
pub const Extensions = struct {
    /// Contains a sequence of one or more policy information terms, each of which
    /// consists of an object identifier (OID) and optional qualifiers. For more
    /// information, see NIST's definition of [Object Identifier
    /// (OID)](https://csrc.nist.gov/glossary/term/Object_Identifier).
    ///
    /// In an end-entity certificate, these terms indicate the policy under which
    /// the certificate was issued and the purposes for which it may be used. In a
    /// CA certificate, these terms limit the set of policies for certification
    /// paths that include this certificate.
    certificate_policies: ?[]const PolicyInformation,

    /// Contains a sequence of one or more X.509 extensions, each of which consists
    /// of an object identifier (OID), a base64-encoded value, and the critical
    /// flag. For more information, see the [Global OID reference
    /// database.](https://oidref.com/2.5.29)
    custom_extensions: ?[]const CustomExtension,

    /// Specifies additional purposes for which the certified public key may be used
    /// other than basic purposes indicated in the `KeyUsage` extension.
    extended_key_usage: ?[]const ExtendedKeyUsage,

    key_usage: ?KeyUsage,

    /// The subject alternative name extension allows identities to be bound to the
    /// subject of the certificate. These identities may be included in addition to
    /// or in place of the identity in the subject field of the certificate.
    subject_alternative_names: ?[]const GeneralName,

    pub const json_field_names = .{
        .certificate_policies = "CertificatePolicies",
        .custom_extensions = "CustomExtensions",
        .extended_key_usage = "ExtendedKeyUsage",
        .key_usage = "KeyUsage",
        .subject_alternative_names = "SubjectAlternativeNames",
    };
};
