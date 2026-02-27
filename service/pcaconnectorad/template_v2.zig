const CertificateValidity = @import("certificate_validity.zig").CertificateValidity;
const EnrollmentFlagsV2 = @import("enrollment_flags_v2.zig").EnrollmentFlagsV2;
const ExtensionsV2 = @import("extensions_v2.zig").ExtensionsV2;
const GeneralFlagsV2 = @import("general_flags_v2.zig").GeneralFlagsV2;
const PrivateKeyAttributesV2 = @import("private_key_attributes_v2.zig").PrivateKeyAttributesV2;
const PrivateKeyFlagsV2 = @import("private_key_flags_v2.zig").PrivateKeyFlagsV2;
const SubjectNameFlagsV2 = @import("subject_name_flags_v2.zig").SubjectNameFlagsV2;

/// v2 template schema that uses Legacy Cryptographic Providers.
pub const TemplateV2 = struct {
    /// Certificate validity describes the validity and renewal periods of a
    /// certificate.
    certificate_validity: CertificateValidity,

    /// Enrollment flags describe the enrollment settings for certificates such as
    /// using the
    /// existing private key and deleting expired or revoked certificates.
    enrollment_flags: EnrollmentFlagsV2,

    /// Extensions describe the key usage extensions and application policies for a
    /// template.
    extensions: ExtensionsV2,

    /// General flags describe whether the template is used for computers or users
    /// and if the
    /// template can be used with autoenrollment.
    general_flags: GeneralFlagsV2,

    /// Private key attributes allow you to specify the minimal key length, key
    /// spec, and
    /// cryptographic providers for the private key of a certificate for v2
    /// templates. V2 templates
    /// allow you to use Legacy Cryptographic Service Providers.
    private_key_attributes: PrivateKeyAttributesV2,

    /// Private key flags for v2 templates specify the client compatibility, if the
    /// private key
    /// can be exported, and if user input is required when using a private key.
    private_key_flags: PrivateKeyFlagsV2,

    /// Subject name flags describe the subject name and subject alternate name that
    /// is included
    /// in a certificate.
    subject_name_flags: SubjectNameFlagsV2,

    /// List of templates in Active Directory that are superseded by this template.
    superseded_templates: ?[]const []const u8,

    pub const json_field_names = .{
        .certificate_validity = "CertificateValidity",
        .enrollment_flags = "EnrollmentFlags",
        .extensions = "Extensions",
        .general_flags = "GeneralFlags",
        .private_key_attributes = "PrivateKeyAttributes",
        .private_key_flags = "PrivateKeyFlags",
        .subject_name_flags = "SubjectNameFlags",
        .superseded_templates = "SupersededTemplates",
    };
};
