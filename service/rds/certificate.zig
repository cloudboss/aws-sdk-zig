/// A CA certificate for an Amazon Web Services account.
///
/// For more information, see [Using SSL/TLS to encrypt a connection to a DB
/// instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html) in the *Amazon RDS User Guide* and [ Using SSL/TLS to encrypt a connection to a DB cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.SSL.html) in the *Amazon Aurora User Guide*.
pub const Certificate = struct {
    /// The Amazon Resource Name (ARN) for the certificate.
    certificate_arn: ?[]const u8 = null,

    /// The unique key that identifies a certificate.
    certificate_identifier: ?[]const u8 = null,

    /// The type of the certificate.
    certificate_type: ?[]const u8 = null,

    /// Indicates whether there is an override for the default certificate
    /// identifier.
    customer_override: ?bool = null,

    /// If there is an override for the default certificate identifier, when the
    /// override expires.
    customer_override_valid_till: ?i64 = null,

    /// The thumbprint of the certificate.
    thumbprint: ?[]const u8 = null,

    /// The starting date from which the certificate is valid.
    valid_from: ?i64 = null,

    /// The final date that the certificate continues to be valid.
    valid_till: ?i64 = null,
};
