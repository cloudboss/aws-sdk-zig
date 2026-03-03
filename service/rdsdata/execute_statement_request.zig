const RecordsFormatType = @import("records_format_type.zig").RecordsFormatType;
const SqlParameter = @import("sql_parameter.zig").SqlParameter;
const ResultSetOptions = @import("result_set_options.zig").ResultSetOptions;

/// The request parameters represent the input of a request to run a SQL
/// statement against
/// a database.
pub const ExecuteStatementRequest = struct {
    /// A value that indicates whether to continue running the statement after
    /// the call times out. By default, the statement stops running when the call
    /// times out.
    ///
    /// For DDL statements, we recommend continuing to run the statement after
    /// the call times out. When a DDL statement terminates before it is finished
    /// running, it can result in errors and possibly corrupted data structures.
    continue_after_timeout: bool = false,

    /// The name of the database.
    database: ?[]const u8 = null,

    /// A value that indicates whether to format the result set as a single JSON
    /// string.
    /// This parameter only applies to `SELECT` statements and is ignored for
    /// other types of statements. Allowed values are `NONE` and `JSON`.
    /// The default value is `NONE`. The result is returned in the
    /// `formattedRecords` field.
    ///
    /// For usage information about the JSON format for result sets, see
    /// [Using the Data
    /// API](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/data-api.html)
    /// in the *Amazon Aurora User Guide*.
    format_records_as: ?RecordsFormatType = null,

    /// A value that indicates whether to include metadata in the results.
    include_result_metadata: bool = false,

    /// The parameters for the SQL statement.
    ///
    /// Array parameters are not supported.
    parameters: ?[]const SqlParameter = null,

    /// The Amazon Resource Name (ARN) of the Aurora Serverless DB cluster.
    resource_arn: []const u8,

    /// Options that control how the result set is returned.
    result_set_options: ?ResultSetOptions = null,

    /// The name of the database schema.
    ///
    /// Currently, the `schema` parameter isn't supported.
    schema: ?[]const u8 = null,

    /// The ARN of the secret that enables access to the DB cluster. Enter the
    /// database user name and password for the credentials in
    /// the secret.
    ///
    /// For information about creating the secret, see [Create a database
    /// secret](https://docs.aws.amazon.com/secretsmanager/latest/userguide/create_database_secret.html).
    secret_arn: []const u8,

    /// The SQL statement to run.
    sql: []const u8,

    /// The identifier of a transaction that was started by using the
    /// `BeginTransaction` operation. Specify the transaction ID of the
    /// transaction that you want to include the SQL statement in.
    ///
    /// If the SQL statement is not part of a transaction, don't set this parameter.
    transaction_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .continue_after_timeout = "continueAfterTimeout",
        .database = "database",
        .format_records_as = "formatRecordsAs",
        .include_result_metadata = "includeResultMetadata",
        .parameters = "parameters",
        .resource_arn = "resourceArn",
        .result_set_options = "resultSetOptions",
        .schema = "schema",
        .secret_arn = "secretArn",
        .sql = "sql",
        .transaction_id = "transactionId",
    };
};
