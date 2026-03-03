/// Any Certificate Manager (ACM) Secure Sockets Layer/Transport Layer Security
/// (SSL/TLS) server certificate that's associated with a
/// ServerCertificateConfiguration. Used in a TLSInspectionConfiguration for
/// inspection of inbound traffic to your firewall. You must request or import a
/// SSL/TLS certificate into ACM for each domain Network Firewall needs to
/// decrypt and inspect. Network Firewall uses the SSL/TLS certificates to
/// decrypt specified inbound SSL/TLS traffic going to your firewall. For
/// information about working with certificates in Certificate Manager, see
/// [Request a public certificate
/// ](https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-request-public.html) or [Importing certificates](https://docs.aws.amazon.com/acm/latest/userguide/import-certificate.html) in the *Certificate Manager User Guide*.
pub const ServerCertificate = struct {
    /// The Amazon Resource Name (ARN) of the Certificate Manager SSL/TLS server
    /// certificate that's used for inbound SSL/TLS inspection.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
