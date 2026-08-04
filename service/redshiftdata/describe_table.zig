const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const ColumnMetadata = @import("column_metadata.zig").ColumnMetadata;

pub const DescribeTableInput = struct {
    /// The cluster identifier. This parameter is required when connecting to a
    /// cluster and authenticating using either Secrets Manager or temporary
    /// credentials.
    cluster_identifier: ?[]const u8 = null,

    /// A database name. The connected database is specified when you connect with
    /// your authentication credentials.
    connected_database: ?[]const u8 = null,

    /// The name of the database that contains the tables to be described. If
    /// `ConnectedDatabase` is not specified, this is also the database to connect
    /// to with your authentication credentials.
    database: []const u8,

    /// The database user name. This parameter is required when connecting to a
    /// cluster as a database user and authenticating using temporary credentials.
    db_user: ?[]const u8 = null,

    /// The maximum number of tables to return in the response. If more tables exist
    /// than fit in one response, then `NextToken` is returned to page through the
    /// results.
    max_results: ?i32 = null,

    /// A value that indicates the starting point for the next set of response
    /// records in a subsequent request. If a value is returned in a response, you
    /// can retrieve the next set of records by providing this returned NextToken
    /// value in the next NextToken parameter and retrying the command. If the
    /// NextToken field is empty, all response records have been retrieved for the
    /// request.
    next_token: ?[]const u8 = null,

    /// The schema that contains the table. If no schema is specified, then matching
    /// tables for all schemas are returned.
    schema: ?[]const u8 = null,

    /// The name or ARN of the secret that enables access to the database. This
    /// parameter is required when authenticating using Secrets Manager.
    secret_arn: ?[]const u8 = null,

    /// The table name. If no table is specified, then all tables for all matching
    /// schemas are returned. If no table and no schema is specified, then all
    /// tables for all schemas in the database are returned
    table: ?[]const u8 = null,

    /// The serverless workgroup name or Amazon Resource Name (ARN). This parameter
    /// is required when connecting to a serverless workgroup and authenticating
    /// using either Secrets Manager or temporary credentials.
    workgroup_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_identifier = "ClusterIdentifier",
        .connected_database = "ConnectedDatabase",
        .database = "Database",
        .db_user = "DbUser",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .schema = "Schema",
        .secret_arn = "SecretArn",
        .table = "Table",
        .workgroup_name = "WorkgroupName",
    };
};

pub const DescribeTableOutput = struct {
    /// A list of columns in the table.
    column_list: ?[]const ColumnMetadata = null,

    /// A value that indicates the starting point for the next set of response
    /// records in a subsequent request. If a value is returned in a response, you
    /// can retrieve the next set of records by providing this returned NextToken
    /// value in the next NextToken parameter and retrying the command. If the
    /// NextToken field is empty, all response records have been retrieved for the
    /// request.
    next_token: ?[]const u8 = null,

    /// The table name.
    table_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .column_list = "ColumnList",
        .next_token = "NextToken",
        .table_name = "TableName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTableInput, options: CallOptions) !DescribeTableOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTableInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftData.DescribeTable");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTableOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeTableOutput, body, allocator);
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
