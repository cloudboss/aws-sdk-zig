const IdentityCertificateStatus = @import("identity_certificate_status.zig").IdentityCertificateStatus;

/// An object that contains information about an S/MIME certificate that's
/// associated with
/// an email identity.
pub const IdentityCertificate = struct {
    /// The Amazon Resource Name (ARN) of the Certificate Manager (ACM) certificate
    /// that's
    /// associated with the email identity.
    certificate_arn: ?[]const u8 = null,

    /// The timestamp after which the certificate is no longer valid.
    certificate_expiry_time: ?i64 = null,

    /// The email address that the certificate applies to.
    from_address: ?[]const u8 = null,

    /// The status of the certificate association. A status of `ACTIVE` indicates
    /// that the certificate is ready to use for signing.
    status: ?IdentityCertificateStatus = null,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .certificate_expiry_time = "CertificateExpiryTime",
        .from_address = "FromAddress",
        .status = "Status",
    };
};
