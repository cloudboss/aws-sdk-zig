const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecordsFormatType = @import("records_format_type.zig").RecordsFormatType;
const SqlParameter = @import("sql_parameter.zig").SqlParameter;
const ResultSetOptions = @import("result_set_options.zig").ResultSetOptions;
const ColumnMetadata = @import("column_metadata.zig").ColumnMetadata;
const Field = @import("field.zig").Field;

pub const ExecuteStatementInput = struct {
    /// A value that indicates whether to continue running the statement after the
    /// call times out. By default, the statement stops running when the call times
    /// out.
    ///
    /// For DDL statements, we recommend continuing to run the statement after the
    /// call times out. When a DDL statement terminates before it is finished
    /// running, it can result in errors and possibly corrupted data structures.
    continue_after_timeout: ?bool = null,

    /// The name of the database.
    database: ?[]const u8 = null,

    /// A value that indicates whether to format the result set as a single JSON
    /// string. This parameter only applies to `SELECT` statements and is ignored
    /// for other types of statements. Allowed values are `NONE` and `JSON`. The
    /// default value is `NONE`. The result is returned in the `formattedRecords`
    /// field.
    ///
    /// For usage information about the JSON format for result sets, see [Using the
    /// Data
    /// API](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/data-api.html) in the *Amazon Aurora User Guide*.
    format_records_as: ?RecordsFormatType = null,

    /// A value that indicates whether to include metadata in the results.
    include_result_metadata: ?bool = null,

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
    /// database user name and password for the credentials in the secret.
    ///
    /// For information about creating the secret, see [Create a database
    /// secret](https://docs.aws.amazon.com/secretsmanager/latest/userguide/create_database_secret.html).
    ///
    /// When you use the CLI on Linux to reference a secret created in the RDS
    /// console, the ARN might include special characters like `rds!cluster`. If you
    /// enclose the ARN in double quotes, the `!` character might trigger a shell
    /// expansion error, such as `-bash: !cluster: event not found`. To avoid this,
    /// escape the exclamation mark (\!) in the ARN or enclose the entire ARN in
    /// single quotes (') instead of double quotes.
    ///
    /// Alternatively, disable shell history expansion by running `set +H` before
    /// you execute the command.
    secret_arn: []const u8,

    /// The SQL statement to run.
    sql: []const u8,

    /// The identifier of a transaction that was started by using the
    /// `BeginTransaction` operation. Specify the transaction ID of the transaction
    /// that you want to include the SQL statement in.
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

pub const ExecuteStatementOutput = struct {
    /// Metadata for the columns included in the results. This field is blank if the
    /// `formatRecordsAs` parameter is set to `JSON`.
    column_metadata: ?[]const ColumnMetadata = null,

    /// A string value that represents the result set of a `SELECT` statement in
    /// JSON format. This value is only present when the `formatRecordsAs` parameter
    /// is set to `JSON`.
    ///
    /// The size limit for this field is currently 10 MB. If the JSON-formatted
    /// string representing the result set requires more than 10 MB, the call
    /// returns an error.
    formatted_records: ?[]const u8 = null,

    /// Values for fields generated during a DML request.
    ///
    /// The `generatedFields` data isn't supported by Aurora PostgreSQL. To get the
    /// values of generated fields, use the `RETURNING` clause. For more
    /// information, see [Returning Data From Modified
    /// Rows](https://www.postgresql.org/docs/10/dml-returning.html) in the
    /// PostgreSQL documentation.
    generated_fields: ?[]const Field = null,

    /// The number of records updated by the request.
    number_of_records_updated: ?i64 = null,

    /// The records returned by the SQL statement. This field is blank if the
    /// `formatRecordsAs` parameter is set to `JSON`.
    records: ?[]const []const Field = null,

    pub const json_field_names = .{
        .column_metadata = "columnMetadata",
        .formatted_records = "formattedRecords",
        .generated_fields = "generatedFields",
        .number_of_records_updated = "numberOfRecordsUpdated",
        .records = "records",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExecuteStatementInput, options: CallOptions) !ExecuteStatementOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds-data", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ExecuteStatementInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds-data", "RDS Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/Execute";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.continue_after_timeout) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"continueAfterTimeout\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.database) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"database\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.format_records_as) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"formatRecordsAs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.include_result_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"includeResultMetadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceArn\":");
    try aws.json.writeValue(@TypeOf(input.resource_arn), input.resource_arn, allocator, &body_buf);
    has_prev = true;
    if (input.result_set_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resultSetOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.schema) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"schema\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"secretArn\":");
    try aws.json.writeValue(@TypeOf(input.secret_arn), input.secret_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sql\":");
    try aws.json.writeValue(@TypeOf(input.sql), input.sql, allocator, &body_buf);
    has_prev = true;
    if (input.transaction_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"transactionId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExecuteStatementOutput {
    const result: ExecuteStatementOutput = try aws.json.parseJsonObject(
        ExecuteStatementOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
