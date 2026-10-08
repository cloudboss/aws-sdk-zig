const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SqlParameter = @import("sql_parameter.zig").SqlParameter;
const UpdateResult = @import("update_result.zig").UpdateResult;

pub const BatchExecuteStatementInput = struct {
    /// The name of the database.
    database: ?[]const u8 = null,

    /// The parameter set for the batch operation.
    ///
    /// The SQL statement is executed as many times as the number of parameter sets
    /// provided. To execute a SQL statement with no parameters, use one of the
    /// following options:
    ///
    /// * Specify one or more empty parameter sets.
    /// * Use the `ExecuteStatement` operation instead of the
    ///   `BatchExecuteStatement` operation.
    ///
    /// Array parameters are not supported.
    parameter_sets: ?[]const []const SqlParameter = null,

    /// The Amazon Resource Name (ARN) of the Aurora Serverless DB cluster.
    resource_arn: []const u8,

    /// The name of the database schema.
    ///
    /// Currently, the `schema` parameter isn't supported.
    schema: ?[]const u8 = null,

    /// The ARN of the secret that enables access to the DB cluster. Enter the
    /// database user name and password for the credentials in the secret.
    ///
    /// For information about creating the secret, see [Create a database
    /// secret](https://docs.aws.amazon.com/secretsmanager/latest/userguide/create_database_secret.html).
    secret_arn: []const u8,

    /// The SQL statement to run. Don't include a semicolon (;) at the end of the
    /// SQL statement.
    sql: []const u8,

    /// The identifier of a transaction that was started by using the
    /// `BeginTransaction` operation. Specify the transaction ID of the transaction
    /// that you want to include the SQL statement in.
    ///
    /// If the SQL statement is not part of a transaction, don't set this parameter.
    transaction_id: ?[]const u8 = null,

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

pub const BatchExecuteStatementOutput = struct {
    /// The execution results of each batch entry.
    update_results: ?[]const UpdateResult = null,

    pub const json_field_names = .{
        .update_results = "updateResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchExecuteStatementInput, options: CallOptions) !BatchExecuteStatementOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchExecuteStatementInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds-data", "RDS Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/BatchExecute";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.database) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"database\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parameter_sets) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parameterSets\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceArn\":");
    try aws.json.writeValue(@TypeOf(input.resource_arn), input.resource_arn, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchExecuteStatementOutput {
    const result: BatchExecuteStatementOutput = try aws.json.parseJsonObject(
        BatchExecuteStatementOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
