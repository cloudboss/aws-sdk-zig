/// An object that represents an Certificate Manager certificate.
pub const ListenerTlsAcmCertificate = struct {
    /// The Amazon Resource Name (ARN) for the certificate. The certificate must
    /// meet specific requirements and you must have proxy authorization enabled.
    /// For more information, see [Transport Layer Security
    /// (TLS)](https://docs.aws.amazon.com/app-mesh/latest/userguide/tls.html#virtual-node-tls-prerequisites).
    certificate_arn: []const u8,

    pub const json_field_names = .{
        .certificate_arn = "certificateArn",
    };
};
