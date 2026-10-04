const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExecutionMode = @import("execution_mode.zig").ExecutionMode;
const SqlParameter = @import("sql_parameter.zig").SqlParameter;
const ResultFormatString = @import("result_format_string.zig").ResultFormatString;
const StatementStatusString = @import("statement_status_string.zig").StatementStatusString;

pub const BatchExecuteStatementInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The cluster identifier. This parameter is required when connecting to a
    /// cluster and authenticating using either Secrets Manager or temporary
    /// credentials.
    cluster_identifier: ?[]const u8 = null,

    /// The name of the database. This parameter is required when authenticating
    /// using either Secrets Manager or temporary credentials.
    database: ?[]const u8 = null,

    /// The database user name. This parameter is required when connecting to a
    /// cluster as a database user and authenticating using temporary credentials.
    db_user: ?[]const u8 = null,

    /// Determines how the SQL statements in the batch are run. If set to
    /// `TRANSACTION` (the default), all SQL statements are run as a single
    /// transaction and they are committed or rolled back together. If set to
    /// `AUTO_COMMIT`, each SQL statement is committed individually, and a failure
    /// of one statement does not affect the others.
    execution_mode: ?ExecutionMode = null,

    /// The parameters for the SQL statements. The parameters are available to all
    /// SQL statements in the batch. Each statement can reference any subset of the
    /// provided parameters. Each provided parameter must be referenced by at least
    /// one SQL statement in the batch.
    parameters: ?[]const SqlParameter = null,

    /// The data format of the result of the SQL statement. If no format is
    /// specified, the default is JSON.
    result_format: ?ResultFormatString = null,

    /// The name or ARN of the secret that enables access to the database. This
    /// parameter is required when authenticating using Secrets Manager.
    secret_arn: ?[]const u8 = null,

    /// The session identifier of the query.
    session_id: ?[]const u8 = null,

    /// The number of seconds to keep the session alive after the query finishes.
    /// The maximum time a session can keep alive is 24 hours. After 24 hours, the
    /// session is forced closed and the query is terminated.
    session_keep_alive_seconds: ?i32 = null,

    /// One or more SQL statements to run. The SQL statements run serially in the
    /// order of the array. Subsequent SQL statements don't start until the previous
    /// statement in the array completes. By default, the SQL statements are run as
    /// a single transaction. If any SQL statement fails, all work is rolled back.
    /// To change this behavior, see the `ExecutionMode` parameter.
    sqls: []const []const u8,

    /// The name of the SQL statements. You can name the SQL statements when you
    /// create them to identify the query.
    statement_name: ?[]const u8 = null,

    /// The number of seconds to wait for all SQL statements in the batch to
    /// complete execution before returning the response. If the SQL statements do
    /// not complete within the specified time, the response returns the current
    /// status. The maximum value is 30 seconds.
    wait_time_seconds: ?i32 = null,

    /// A value that indicates whether to send an event to the Amazon EventBridge
    /// event bus after the SQL statements run.
    with_event: ?bool = null,

    /// The serverless workgroup name or Amazon Resource Name (ARN). This parameter
    /// is required when connecting to a serverless workgroup and authenticating
    /// using either Secrets Manager or temporary credentials.
    workgroup_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .cluster_identifier = "ClusterIdentifier",
        .database = "Database",
        .db_user = "DbUser",
        .execution_mode = "ExecutionMode",
        .parameters = "Parameters",
        .result_format = "ResultFormat",
        .secret_arn = "SecretArn",
        .session_id = "SessionId",
        .session_keep_alive_seconds = "SessionKeepAliveSeconds",
        .sqls = "Sqls",
        .statement_name = "StatementName",
        .wait_time_seconds = "WaitTimeSeconds",
        .with_event = "WithEvent",
        .workgroup_name = "WorkgroupName",
    };
};

pub const BatchExecuteStatementOutput = struct {
    /// The cluster identifier. This element is not returned when connecting to a
    /// serverless workgroup.
    cluster_identifier: ?[]const u8 = null,

    /// The date and time (UTC) the statement was created.
    created_at: ?i64 = null,

    /// The name of the database.
    database: ?[]const u8 = null,

    /// A list of colon (:) separated names of database groups.
    db_groups: ?[]const []const u8 = null,

    /// The database user name.
    db_user: ?[]const u8 = null,

    /// A value that indicates whether the statement has a result set. The result
    /// set can be empty. The value is true for an empty result set. The value is
    /// true if any substatement returns a result set.
    has_result_set: ?bool = null,

    /// The identifier of the SQL statement whose results are to be fetched. This
    /// value is a universally unique identifier (UUID) generated by Amazon Redshift
    /// Data API. This identifier is returned by `BatchExecuteStatment`.
    id: ?[]const u8 = null,

    /// The process identifier from Amazon Redshift.
    redshift_pid: ?i64 = null,

    /// The name or ARN of the secret that enables access to the database.
    secret_arn: ?[]const u8 = null,

    /// The session identifier of the query.
    session_id: ?[]const u8 = null,

    /// The status of the SQL statement. Status values are defined as follows:
    ///
    /// * ABORTED - The query run was stopped by the user.
    /// * FAILED - The query run failed.
    /// * FINISHED - The query has finished running.
    /// * PICKED - The query has been chosen to be run.
    /// * STARTED - The query run has started.
    /// * SUBMITTED - The query was submitted, but not yet processed.
    status: ?StatementStatusString = null,

    /// The serverless workgroup name or Amazon Resource Name (ARN). This element is
    /// not returned when connecting to a provisioned cluster.
    workgroup_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_identifier = "ClusterIdentifier",
        .created_at = "CreatedAt",
        .database = "Database",
        .db_groups = "DbGroups",
        .db_user = "DbUser",
        .has_result_set = "HasResultSet",
        .id = "Id",
        .redshift_pid = "RedshiftPid",
        .secret_arn = "SecretArn",
        .session_id = "SessionId",
        .status = "Status",
        .workgroup_name = "WorkgroupName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchExecuteStatementInput, options: CallOptions) !BatchExecuteStatementOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-data", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("redshift-data", "Redshift Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftData.BatchExecuteStatement");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchExecuteStatementOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchExecuteStatementOutput, body, allocator);
}
