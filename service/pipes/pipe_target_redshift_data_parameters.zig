/// These are custom parameters to be used when the target is a Amazon Redshift
/// cluster to invoke the
/// Amazon Redshift Data API BatchExecuteStatement.
pub const PipeTargetRedshiftDataParameters = struct {
    /// The name of the database. Required when authenticating using temporary
    /// credentials.
    database: []const u8,

    /// The database user name. Required when authenticating using temporary
    /// credentials.
    db_user: ?[]const u8 = null,

    /// The name or ARN of the secret that enables access to the database. Required
    /// when
    /// authenticating using Secrets Manager.
    secret_manager_arn: ?[]const u8 = null,

    /// The SQL statement text to run.
    sqls: []const []const u8,

    /// The name of the SQL statement. You can name the SQL statement when you
    /// create it to
    /// identify the query.
    statement_name: ?[]const u8 = null,

    /// Indicates whether to send an event back to EventBridge after the SQL
    /// statement
    /// runs.
    with_event: bool = false,

    pub const json_field_names = .{
        .database = "Database",
        .db_user = "DbUser",
        .secret_manager_arn = "SecretManagerArn",
        .sqls = "Sqls",
        .statement_name = "StatementName",
        .with_event = "WithEvent",
    };
};
