/// The external MySQL-compatible database that the Slurm accounting daemon
/// (`slurmdbd`) connects to for a SageMaker HyperPod cluster. You provide the
/// database credentials in an Amazon Web Services Secrets Manager secret
/// instead of in the request.
pub const ClusterAccountingDatabase = struct {
    /// The hostname or endpoint of the accounting database, such as the endpoint of
    /// an Amazon RDS for MySQL or Aurora MySQL database. The database must be
    /// reachable from the subnets and security groups that you configure for the
    /// cluster.
    endpoint: []const u8,

    /// The name of the database schema that stores the Slurm accounting data. The
    /// default is `slurm_acct_db_` followed by the cluster ID from the cluster ARN,
    /// for example `slurm_acct_db_a1b2c3d4e5f6`.
    name: ?[]const u8 = null,

    /// The port that the accounting database listens on. The default is `3306`.
    port: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Secrets Manager
    /// secret that contains the user name and password for the accounting database.
    /// The database user must be able to create the schema and to read from and
    /// write to it.
    secret_arn: []const u8,

    pub const json_field_names = .{
        .endpoint = "Endpoint",
        .name = "Name",
        .port = "Port",
        .secret_arn = "SecretArn",
    };
};
