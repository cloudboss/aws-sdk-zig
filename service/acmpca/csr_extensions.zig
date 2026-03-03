const KeyUsage = @import("key_usage.zig").KeyUsage;
const AccessDescription = @import("access_description.zig").AccessDescription;

/// Describes the certificate extensions to be added to the certificate signing
/// request (CSR).
pub const CsrExtensions = struct {
    /// Indicates the purpose of the certificate and of the key contained in the
    /// certificate.
    key_usage: ?KeyUsage = null,

    /// For CA certificates, provides a path to additional information pertaining to
    /// the CA, such as revocation and policy. For more information, see [Subject
    /// Information
    /// Access](https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.2.2) in
    /// RFC 5280.
    subject_information_access: ?[]const AccessDescription = null,

    pub const json_field_names = .{
        .key_usage = "KeyUsage",
        .subject_information_access = "SubjectInformationAccess",
    };
};
