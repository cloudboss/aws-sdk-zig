const CertificateExport = @import("certificate_export.zig").CertificateExport;
const ExtendedKeyUsageName = @import("extended_key_usage_name.zig").ExtendedKeyUsageName;
const KeyAlgorithm = @import("key_algorithm.zig").KeyAlgorithm;
const KeyUsageName = @import("key_usage_name.zig").KeyUsageName;
const CertificateManagedBy = @import("certificate_managed_by.zig").CertificateManagedBy;

/// This structure can be used in the ListCertificates action to filter the
/// output of the certificate list.
pub const Filters = struct {
    /// Specify `ENABLED` or `DISABLED` to identify certificates that can be
    /// exported.
    export_option: ?CertificateExport,

    /// Specify one or more ExtendedKeyUsage extension values.
    extended_key_usage: ?[]const ExtendedKeyUsageName,

    /// Specify one or more algorithms that can be used to generate key pairs.
    ///
    /// Default filtering returns only `RSA_1024` and `RSA_2048` certificates that
    /// have at least one domain. To return other certificate types, provide the
    /// desired type signatures in a comma-separated list. For example, `"keyTypes":
    /// ["RSA_2048","RSA_4096"]` returns both `RSA_2048` and `RSA_4096`
    /// certificates.
    key_types: ?[]const KeyAlgorithm,

    /// Specify one or more KeyUsage extension values.
    key_usage: ?[]const KeyUsageName,

    /// Identifies the Amazon Web Services service that manages the certificate
    /// issued by ACM.
    managed_by: ?CertificateManagedBy,

    pub const json_field_names = .{
        .export_option = "exportOption",
        .extended_key_usage = "extendedKeyUsage",
        .key_types = "keyTypes",
        .key_usage = "keyUsage",
        .managed_by = "managedBy",
    };
};
