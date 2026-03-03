const CertificateValidity = @import("certificate_validity.zig").CertificateValidity;
const EnrollmentFlagsV4 = @import("enrollment_flags_v4.zig").EnrollmentFlagsV4;
const ExtensionsV4 = @import("extensions_v4.zig").ExtensionsV4;
const GeneralFlagsV4 = @import("general_flags_v4.zig").GeneralFlagsV4;
const HashAlgorithm = @import("hash_algorithm.zig").HashAlgorithm;
const PrivateKeyAttributesV4 = @import("private_key_attributes_v4.zig").PrivateKeyAttributesV4;
const PrivateKeyFlagsV4 = @import("private_key_flags_v4.zig").PrivateKeyFlagsV4;
const SubjectNameFlagsV4 = @import("subject_name_flags_v4.zig").SubjectNameFlagsV4;

/// v4 template schema that can use either Legacy Cryptographic Providers or Key
/// Storage
/// Providers.
pub const TemplateV4 = struct {
    /// Certificate validity describes the validity and renewal periods of a
    /// certificate.
    certificate_validity: CertificateValidity,

    /// Enrollment flags describe the enrollment settings for certificates using the
    /// existing
    /// private key and deleting expired or revoked certificates.
    enrollment_flags: EnrollmentFlagsV4,

    /// Extensions describe the key usage extensions and application policies for a
    /// template.
    extensions: ExtensionsV4,

    /// General flags describe whether the template is used for computers or users
    /// and if the
    /// template can be used with autoenrollment.
    general_flags: GeneralFlagsV4,

    /// Specifies the hash algorithm used to hash the private key. Hash algorithm
    /// can only be
    /// specified when using Key Storage Providers.
    hash_algorithm: ?HashAlgorithm = null,

    /// Private key attributes allow you to specify the minimal key length, key
    /// spec, key usage,
    /// and cryptographic providers for the private key of a certificate for v4
    /// templates. V4
    /// templates allow you to use either Key Storage Providers or Legacy
    /// Cryptographic Service
    /// Providers. You specify the cryptography provider category in private key
    /// flags.
    private_key_attributes: PrivateKeyAttributesV4,

    /// Private key flags for v4 templates specify the client compatibility, if the
    /// private key
    /// can be exported, if user input is required when using a private key, if an
    /// alternate
    /// signature algorithm should be used, and if certificates are renewed using
    /// the same private
    /// key.
    private_key_flags: PrivateKeyFlagsV4,

    /// Subject name flags describe the subject name and subject alternate name that
    /// is included
    /// in a certificate.
    subject_name_flags: SubjectNameFlagsV4,

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
