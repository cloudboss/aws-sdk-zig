const CertificateStatusType = @import("certificate_status_type.zig").CertificateStatusType;
const CertificateType = @import("certificate_type.zig").CertificateType;
const CertificateUsageType = @import("certificate_usage_type.zig").CertificateUsageType;

/// Describes the properties of a certificate.
pub const ListedCertificate = struct {
    /// An optional date that specifies when the certificate becomes active. If you
    /// do not specify a value, `ActiveDate` takes the same value as
    /// `NotBeforeDate`, which is specified by the CA.
    active_date: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the specified certificate.
    arn: ?[]const u8 = null,

    /// An array of identifiers for the imported certificates. You use this
    /// identifier for working with profiles and partner profiles.
    certificate_id: ?[]const u8 = null,

    /// The name or short description that's used to identify the certificate.
    description: ?[]const u8 = null,

    /// An optional date that specifies when the certificate becomes inactive. If
    /// you do not specify a value, `InactiveDate` takes the same value as
    /// `NotAfterDate`, which is specified by the CA.
    inactive_date: ?i64 = null,

    /// The certificate can be either `ACTIVE`, `PENDING_ROTATION`, or `INACTIVE`.
    /// `PENDING_ROTATION` means that this certificate will replace the current
    /// certificate when it expires.
    status: ?CertificateStatusType = null,

    /// The type for the certificate. If a private key has been specified for the
    /// certificate, its type is `CERTIFICATE_WITH_PRIVATE_KEY`. If there is no
    /// private key, the type is `CERTIFICATE`.
    @"type": ?CertificateType = null,

    /// Specifies how this certificate is used. It can be used in the following
    /// ways:
    ///
    /// * `SIGNING`: For signing AS2 messages
    /// * `ENCRYPTION`: For encrypting AS2 messages
    /// * `TLS`: For securing AS2 communications sent over HTTPS
    usage: ?CertificateUsageType = null,

    pub const json_field_names = .{
        .active_date = "ActiveDate",
        .arn = "Arn",
        .certificate_id = "CertificateId",
        .description = "Description",
        .inactive_date = "InactiveDate",
        .status = "Status",
        .@"type" = "Type",
        .usage = "Usage",
    };
};
