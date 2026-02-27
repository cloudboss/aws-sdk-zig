/// Contains metadata about an Certificate Manager certificate.
pub const TlsCertificateData = struct {
    /// The Amazon Resource Name (ARN) of the certificate.
    certificate_arn: ?[]const u8,

    /// The serial number of the certificate.
    certificate_serial: ?[]const u8,

    /// The status of the certificate.
    status: ?[]const u8,

    /// Contains details about the certificate status, including information about
    /// certificate errors.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .certificate_serial = "CertificateSerial",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
