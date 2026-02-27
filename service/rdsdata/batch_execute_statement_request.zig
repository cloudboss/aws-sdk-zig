const SqlParameter = @import("sql_parameter.zig").SqlParameter;

/// The request parameters represent the input of a SQL statement over an array
/// of
/// data.
pub const BatchExecuteStatementRequest = struct {
    /// The name of the database.
    database: ?[]const u8,

    /// The parameter set for the batch operation.
    ///
    /// The SQL statement is executed as many times as the number of parameter sets
    /// provided.
    /// To execute a SQL statement with no parameters, use one of the following
    /// options:
    ///
    /// * Specify one or more empty parameter sets.
    ///
    /// * Use the `ExecuteStatement` operation instead of the
    ///   `BatchExecuteStatement` operation.
    ///
    /// Array parameters are not supported.
    parameter_sets: ?[]const []const SqlParameter,

    /// The Amazon Resource Name (ARN) of the Aurora Serverless DB cluster.
    resource_arn: []const u8,

    /// The name of the database schema.
    ///
    /// Currently, the `schema` parameter isn't supported.
    schema: ?[]const u8,

    /// The ARN of the secret that enables access to the DB cluster. Enter the
    /// database user name and password for the credentials in
    /// the secret.
    ///
    /// For information about creating the secret, see [Create a database
    /// secret](https://docs.aws.amazon.com/secretsmanager/latest/userguide/create_database_secret.html).
    secret_arn: []const u8,

    /// The SQL statement to run. Don't include a semicolon (;) at the end of the
    /// SQL statement.
    sql: []const u8,

    /// The identifier of a transaction that was started by using the
    /// `BeginTransaction` operation. Specify the transaction ID of the
    /// transaction that you want to include the SQL statement in.
    ///
    /// If the SQL statement is not part of a transaction, don't set this
    /// parameter.
    transaction_id: ?[]const u8,

    pub const json_field_names = .{
        .database = "database",
        .parameter_sets = "parameterSets",
        .resource_arn = "resourceArn",
        .schema = "schema",
        .secret_arn = "secretArn",
        .sql = "sql",
        .transaction_id = "transactionId",
    };
};
