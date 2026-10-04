/// The configuration for a single resource in the green environment of a
/// blue/green deployment.
///
/// Use `SourceArn` to identify a resource in the blue environment. Amazon RDS
/// creates the corresponding resource in the green environment using this
/// configuration.
///
/// This data type is a request parameter of the `CreateBlueGreenDeployment`
/// operation.
pub const TargetResourceConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the DB cluster or DB instance in the blue
    /// environment to which this configuration applies.
    source_arn: []const u8,

    /// The Amazon Web Services KMS key identifier for encryption of the
    /// corresponding resource in the green environment.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key.
    ///
    /// Specify this setting in either of the following cases:
    ///
    /// * You want the green resource to use a different KMS key than the blue
    ///   resource.
    /// * The blue resource is unencrypted and you want to encrypt the green
    ///   resource.
    ///
    /// For Aurora, encryption applies at the DB cluster level. Specify a DB cluster
    /// ARN in `SourceArn`. All DB instances in that cluster use the same KMS key.
    ///
    /// For RDS, encryption applies at the DB instance level. Specify a DB instance
    /// ARN in `SourceArn`. To encrypt read replicas, include a separate entry for
    /// each one. Each entry can specify a different KMS key.
    target_kms_key_id: ?[]const u8 = null,
};
