/// The Amazon Relational Database Service (Amazon RDS) HTTP endpoint
/// configuration.
pub const RdsHttpEndpointConfig = struct {
    /// Amazon Web Services Region for Amazon RDS HTTP endpoint.
    aws_region: ?[]const u8,

    /// Amazon Web Services secret store Amazon Resource Name (ARN) for database
    /// credentials.
    aws_secret_store_arn: ?[]const u8,

    /// Logical database name.
    database_name: ?[]const u8,

    /// Amazon RDS cluster Amazon Resource Name (ARN).
    db_cluster_identifier: ?[]const u8,

    /// Logical schema name.
    schema: ?[]const u8,

    pub const json_field_names = .{
        .aws_region = "awsRegion",
        .aws_secret_store_arn = "awsSecretStoreArn",
        .database_name = "databaseName",
        .db_cluster_identifier = "dbClusterIdentifier",
        .schema = "schema",
    };
};
