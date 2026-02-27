const RDSDatabase = @import("rds_database.zig").RDSDatabase;

/// The datasource details that are specific to Amazon RDS.
pub const RDSMetadata = struct {
    /// The database details required to connect to an Amazon RDS.
    database: ?RDSDatabase,

    database_user_name: ?[]const u8,

    /// The ID of the Data Pipeline instance that is used to carry to copy data from
    /// Amazon RDS to Amazon S3. You can use the ID to find details about the
    /// instance in the Data Pipeline console.
    data_pipeline_id: ?[]const u8,

    /// The role (DataPipelineDefaultResourceRole) assumed by an Amazon EC2 instance
    /// to carry out the copy task from Amazon RDS to Amazon S3. For more
    /// information, see [Role
    /// templates](https://docs.aws.amazon.com/datapipeline/latest/DeveloperGuide/dp-iam-roles.html) for data pipelines.
    resource_role: ?[]const u8,

    /// The SQL query that is supplied during CreateDataSourceFromRDS. Returns only
    /// if `Verbose` is true in `GetDataSourceInput`.
    select_sql_query: ?[]const u8,

    /// The role (DataPipelineDefaultRole) assumed by the Data Pipeline service to
    /// monitor the progress of the copy task from Amazon RDS to Amazon S3. For more
    /// information, see [Role
    /// templates](https://docs.aws.amazon.com/datapipeline/latest/DeveloperGuide/dp-iam-roles.html) for data pipelines.
    service_role: ?[]const u8,

    pub const json_field_names = .{
        .database = "Database",
        .database_user_name = "DatabaseUserName",
        .data_pipeline_id = "DataPipelineId",
        .resource_role = "ResourceRole",
        .select_sql_query = "SelectSqlQuery",
        .service_role = "ServiceRole",
    };
};
