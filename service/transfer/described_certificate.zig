const CertificateStatusType = @import("certificate_status_type.zig").CertificateStatusType;
const Tag = @import("tag.zig").Tag;
const CertificateType = @import("certificate_type.zig").CertificateType;
const CertificateUsageType = @import("certificate_usage_type.zig").CertificateUsageType;

/// Describes the properties of a certificate.
pub const DescribedCertificate = struct {
    /// An optional date that specifies when the certificate becomes active. If you
    /// do not specify a value, `ActiveDate` takes the same value as
    /// `NotBeforeDate`, which is specified by the CA.
    active_date: ?i64,

    /// The unique Amazon Resource Name (ARN) for the certificate.
    arn: []const u8,

    /// The file name for the certificate.
    certificate: ?[]const u8,

    /// The list of certificates that make up the chain for the certificate.
    certificate_chain: ?[]const u8,

    /// An array of identifiers for the imported certificates. You use this
    /// identifier for working with profiles and partner profiles.
    certificate_id: ?[]const u8,

    /// The name or description that's used to identity the certificate.
    description: ?[]const u8,

    /// An optional date that specifies when the certificate becomes inactive. If
    /// you do not specify a value, `InactiveDate` takes the same value as
    /// `NotAfterDate`, which is specified by the CA.
    inactive_date: ?i64,

    /// The final date that the certificate is valid.
    not_after_date: ?i64,

    /// The earliest date that the certificate is valid.
    not_before_date: ?i64,

    /// The serial number for the certificate.
    serial: ?[]const u8,

    /// A certificate's status can be either `ACTIVE` or `INACTIVE`.
    ///
    /// You can set `ActiveDate` and `InactiveDate` in the `UpdateCertificate` call.
    /// If you set values for these parameters, those values are used to determine
    /// whether the certificate has a status of `ACTIVE` or `INACTIVE`.
    ///
    /// If you don't set values for `ActiveDate` and `InactiveDate`, we use the
    /// `NotBefore` and `NotAfter` date as specified on the X509 certificate to
    /// determine when a certificate is active and when it is inactive.
    status: ?CertificateStatusType,

    /// Key-value pairs that can be used to group and search for certificates.
    tags: ?[]const Tag,

    /// If a private key has been specified for the certificate, its type is
    /// `CERTIFICATE_WITH_PRIVATE_KEY`. If there is no private key, the type is
    /// `CERTIFICATE`.
    type: ?CertificateType,

    /// Specifies how this certificate is used. It can be used in the following
    /// ways:
    ///
    /// * `SIGNING`: For signing AS2 messages
    /// * `ENCRYPTION`: For encrypting AS2 messages
    /// * `TLS`: For securing AS2 communications sent over HTTPS
    usage: ?CertificateUsageType,

    pub const json_field_names = .{
        .active_date = "ActiveDate",
        .arn = "Arn",
        .certificate = "Certificate",
        .certificate_chain = "CertificateChain",
        .certificate_id = "CertificateId",
        .description = "Description",
        .inactive_date = "InactiveDate",
        .not_after_date = "NotAfterDate",
        .not_before_date = "NotBeforeDate",
        .serial = "Serial",
        .status = "Status",
        .tags = "Tags",
        .type = "Type",
        .usage = "Usage",
    };
};
