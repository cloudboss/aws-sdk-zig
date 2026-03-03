const CertificateValidity = @import("certificate_validity.zig").CertificateValidity;
const EnrollmentFlagsV3 = @import("enrollment_flags_v3.zig").EnrollmentFlagsV3;
const ExtensionsV3 = @import("extensions_v3.zig").ExtensionsV3;
const GeneralFlagsV3 = @import("general_flags_v3.zig").GeneralFlagsV3;
const HashAlgorithm = @import("hash_algorithm.zig").HashAlgorithm;
const PrivateKeyAttributesV3 = @import("private_key_attributes_v3.zig").PrivateKeyAttributesV3;
const PrivateKeyFlagsV3 = @import("private_key_flags_v3.zig").PrivateKeyFlagsV3;
const SubjectNameFlagsV3 = @import("subject_name_flags_v3.zig").SubjectNameFlagsV3;

/// v3 template schema that uses Key Storage Providers.
pub const TemplateV3 = struct {
    /// Certificate validity describes the validity and renewal periods of a
    /// certificate.
    certificate_validity: CertificateValidity,

    /// Enrollment flags describe the enrollment settings for certificates such as
    /// using the
    /// existing private key and deleting expired or revoked certificates.
    enrollment_flags: EnrollmentFlagsV3,

    /// Extensions describe the key usage extensions and application policies for a
    /// template.
    extensions: ExtensionsV3,

    /// General flags describe whether the template is used for computers or users
    /// and if the
    /// template can be used with autoenrollment.
    general_flags: GeneralFlagsV3,

    /// Specifies the hash algorithm used to hash the private key.
    hash_algorithm: HashAlgorithm,

    /// Private key attributes allow you to specify the algorithm, minimal key
    /// length, key spec,
    /// key usage, and cryptographic providers for the private key of a certificate
    /// for v3
    /// templates. V3 templates allow you to use Key Storage Providers.
    private_key_attributes: PrivateKeyAttributesV3,

    /// Private key flags for v3 templates specify the client compatibility, if the
    /// private key
    /// can be exported, if user input is required when using a private key, and if
    /// an alternate
    /// signature algorithm should be used.
    private_key_flags: PrivateKeyFlagsV3,

    /// Subject name flags describe the subject name and subject alternate name that
    /// is included
    /// in a certificate.
    subject_name_flags: SubjectNameFlagsV3,

    /// List of templates in Active Directory that are superseded by this template.
    superseded_templates: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .certificate_validity = "CertificateValidity",
        .enrollment_flags = "EnrollmentFlags",
        .extensions = "Extensions",
        .general_flags = "GeneralFlags",
        .hash_algorithm = "HashAlgorithm",
        .private_key_attributes = "PrivateKeyAttributes",
        .private_key_flags = "PrivateKeyFlags",
        .subject_name_flags = "SubjectNameFlags",
        .superseded_templates = "SupersededTemplates",
    };
};
