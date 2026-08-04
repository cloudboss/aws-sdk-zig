const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ActiveSessionsExceededException")) {
        const parsed_error: ?errors.ActiveSessionsExceededException = aws.json.parseJsonObject(errors.ActiveSessionsExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .active_sessions_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ActiveStatementsExceededException")) {
        const parsed_error: ?errors.ActiveStatementsExceededException = aws.json.parseJsonObject(errors.ActiveStatementsExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .active_statements_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BatchExecuteStatementException")) {
        const parsed_error: ?errors.BatchExecuteStatementException = aws.json.parseJsonObject(errors.BatchExecuteStatementException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .batch_execute_statement_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DatabaseConnectionException")) {
        const parsed_error: ?errors.DatabaseConnectionException = aws.json.parseJsonObject(errors.DatabaseConnectionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .database_connection_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ExecuteStatementException")) {
        const parsed_error: ?errors.ExecuteStatementException = aws.json.parseJsonObject(errors.ExecuteStatementException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .execute_statement_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        const parsed_error: ?errors.InternalServerException = aws.json.parseJsonObject(errors.InternalServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "QueryTimeoutException")) {
        const parsed_error: ?errors.QueryTimeoutException = aws.json.parseJsonObject(errors.QueryTimeoutException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .query_timeout_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
