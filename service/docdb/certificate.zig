/// A certificate authority (CA) certificate for an Amazon Web Services account.
pub const Certificate = struct {
    /// The Amazon Resource Name (ARN) for the certificate.
    ///
    /// Example: `arn:aws:rds:us-east-1::cert:rds-ca-2019`
    certificate_arn: ?[]const u8,

    /// The unique key that identifies a certificate.
    ///
    /// Example: `rds-ca-2019`
    certificate_identifier: ?[]const u8,

    /// The type of the certificate.
    ///
    /// Example: `CA`
    certificate_type: ?[]const u8,

    /// The thumbprint of the certificate.
    thumbprint: ?[]const u8,

    /// The starting date-time from which the certificate is valid.
    ///
    /// Example: `2019-07-31T17:57:09Z`
    valid_from: ?i64,

    /// The date-time after which the certificate is no longer valid.
    ///
    /// Example: `2024-07-31T17:57:09Z`
    valid_till: ?i64,
};
