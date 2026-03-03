/// The SSL certificate that can be used to encrypt connections between the
/// endpoints and
/// the replication instance.
pub const Certificate = struct {
    /// The Amazon Resource Name (ARN) for the certificate.
    certificate_arn: ?[]const u8 = null,

    /// The date that the certificate was created.
    certificate_creation_date: ?i64 = null,

    /// A customer-assigned name for the certificate. Identifiers must begin with a
    /// letter and
    /// must contain only ASCII letters, digits, and hyphens. They can't end with a
    /// hyphen or
    /// contain two consecutive hyphens.
    certificate_identifier: ?[]const u8 = null,

    /// The owner of the certificate.
    certificate_owner: ?[]const u8 = null,

    /// The contents of a `.pem` file, which contains an X.509 certificate.
    certificate_pem: ?[]const u8 = null,

    /// The location of an imported Oracle Wallet certificate for use with SSL.
    /// Example:
    /// `filebase64("${path.root}/rds-ca-2019-root.sso")`
    certificate_wallet: ?[]const u8 = null,

    /// The key length of the cryptographic algorithm being used.
    key_length: ?i32 = null,

    /// An KMS key identifier that is used to encrypt the certificate.
    ///
    /// If you don't specify a value for the `KmsKeyId` parameter, then DMS uses
    /// your default encryption key.
    ///
    /// KMS creates the default encryption key for your Amazon Web Services account.
    /// Your Amazon Web Services account has
    /// a different default encryption key for each Amazon Web Services Region.
    kms_key_id: ?[]const u8 = null,

    /// The signing algorithm for the certificate.
    signing_algorithm: ?[]const u8 = null,

    /// The beginning date that the certificate is valid.
    valid_from_date: ?i64 = null,

    /// The final date that the certificate is valid.
    valid_to_date: ?i64 = null,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .certificate_creation_date = "CertificateCreationDate",
        .certificate_identifier = "CertificateIdentifier",
        .certificate_owner = "CertificateOwner",
        .certificate_pem = "CertificatePem",
        .certificate_wallet = "CertificateWallet",
        .key_length = "KeyLength",
        .kms_key_id = "KmsKeyId",
        .signing_algorithm = "SigningAlgorithm",
        .valid_from_date = "ValidFromDate",
        .valid_to_date = "ValidToDate",
    };
};
