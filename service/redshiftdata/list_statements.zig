const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StatusString = @import("status_string.zig").StatusString;
const StatementData = @import("statement_data.zig").StatementData;

pub const ListStatementsInput = struct {
    /// The cluster identifier. Only statements that ran on this cluster are
    /// returned. When providing `ClusterIdentifier`, then `WorkgroupName` can't be
    /// specified.
    cluster_identifier: ?[]const u8 = null,

    /// The name of the database when listing statements run against a
    /// `ClusterIdentifier` or `WorkgroupName`.
    database: ?[]const u8 = null,

    /// The maximum number of SQL statements to return in the response. If more SQL
    /// statements exist than fit in one response, then `NextToken` is returned to
    /// page through the results.
    max_results: ?i32 = null,

    /// A value that indicates the starting point for the next set of response
    /// records in a subsequent request. If a value is returned in a response, you
    /// can retrieve the next set of records by providing this returned NextToken
    /// value in the next NextToken parameter and retrying the command. If the
    /// NextToken field is empty, all response records have been retrieved for the
    /// request.
    next_token: ?[]const u8 = null,

    /// A value that filters which statements to return in the response. If true,
    /// all statements run by the caller's IAM role are returned. If false, only
    /// statements run by the caller's IAM role in the current IAM session are
    /// returned. The default is true.
    role_level: ?bool = null,

    /// The name of the SQL statement specified as input to `BatchExecuteStatement`
    /// or `ExecuteStatement` to identify the query. You can list multiple
    /// statements by providing a prefix that matches the beginning of the statement
    /// name. For example, to list myStatement1, myStatement2, myStatement3, and so
    /// on, then provide the a value of `myStatement`. Data API does a
    /// case-sensitive match of SQL statement names to the prefix value you provide.
    statement_name: ?[]const u8 = null,

    /// The status of the SQL statement to list. Status values are defined as
    /// follows:
    ///
    /// * ABORTED - The query run was stopped by the user.
    /// * ALL - A status value that includes all query statuses. This value can be
    ///   used to filter results.
    /// * FAILED - The query run failed.
    /// * FINISHED - The query has finished running.
    /// * PICKED - The query has been chosen to be run.
    /// * STARTED - The query run has started.
    /// * SUBMITTED - The query was submitted, but not yet processed.
    status: ?StatusString = null,

    /// The serverless workgroup name or Amazon Resource Name (ARN). Only statements
    /// that ran on this workgroup are returned. When providing `WorkgroupName`,
    /// then `ClusterIdentifier` can't be specified.
    workgroup_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_identifier = "ClusterIdentifier",
        .database = "Database",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .role_level = "RoleLevel",
        .statement_name = "StatementName",
        .status = "Status",
        .workgroup_name = "WorkgroupName",
    };
};

pub const ListStatementsOutput = struct {
    /// A value that indicates the starting point for the next set of response
    /// records in a subsequent request. If a value is returned in a response, you
    /// can retrieve the next set of records by providing this returned NextToken
    /// value in the next NextToken parameter and retrying the command. If the
    /// NextToken field is empty, all response records have been retrieved for the
    /// request.
    next_token: ?[]const u8 = null,

    /// The SQL statements.
    statements: ?[]const StatementData = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .statements = "Statements",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStatementsInput, options: CallOptions) !ListStatementsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStatementsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftData.ListStatements");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStatementsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListStatementsOutput, body, allocator);
}
