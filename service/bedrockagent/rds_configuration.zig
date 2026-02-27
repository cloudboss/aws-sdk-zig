const RdsFieldMapping = @import("rds_field_mapping.zig").RdsFieldMapping;

/// Contains details about the storage configuration of the knowledge base in
/// Amazon RDS. For more information, see [Create a vector index in Amazon
/// RDS](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-setup-rds.html).
pub const RdsConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the secret that you created in Secrets
    /// Manager that is linked to your Amazon RDS database.
    credentials_secret_arn: []const u8,

    /// The name of your Amazon RDS database.
    database_name: []const u8,

    /// Contains the names of the fields to which to map information about the
    /// vector store.
    field_mapping: RdsFieldMapping,

    /// The Amazon Resource Name (ARN) of the vector store.
    resource_arn: []const u8,

    /// The name of the table in the database.
    table_name: []const u8,

    pub const json_field_names = .{
        .credentials_secret_arn = "credentialsSecretArn",
        .database_name = "databaseName",
        .field_mapping = "fieldMapping",
        .resource_arn = "resourceArn",
        .table_name = "tableName",
    };
};
