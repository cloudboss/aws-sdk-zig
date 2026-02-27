/// Contains the secret managed by RDS in Amazon Web Services Secrets Manager
/// for the master user password.
///
/// For more information, see [Password management with Amazon Web Services
/// Secrets
/// Manager](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html) in the *Amazon RDS User Guide* and [Password management with Amazon Web Services Secrets Manager](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/rds-secrets-manager.html) in the *Amazon Aurora User Guide.*
pub const MasterUserSecret = struct {
    /// The Amazon Web Services KMS key identifier that is used to encrypt the
    /// secret.
    kms_key_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the secret.
    secret_arn: ?[]const u8,

    /// The status of the secret.
    ///
    /// The possible status values include the following:
    ///
    /// * `creating` - The secret is being created.
    /// * `active` - The secret is available for normal use and rotation.
    /// * `rotating` - The secret is being rotated.
    /// * `impaired` - The secret can be used to access database credentials, but it
    ///   can't be rotated. A secret might have this status if, for example,
    ///   permissions are changed so that RDS can no longer access either the secret
    ///   or the KMS key for the secret.
    ///
    /// When a secret has this status, you can correct the condition that caused the
    /// status. Alternatively, modify the DB instance to turn off automatic
    /// management of database credentials, and then modify the DB instance again to
    /// turn on automatic management of database credentials.
    secret_status: ?[]const u8,
};
