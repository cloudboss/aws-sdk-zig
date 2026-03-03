const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TableMember = @import("table_member.zig").TableMember;

pub const ListTablesInput = struct {
    /// The cluster identifier. This parameter is required when connecting to a
    /// cluster and authenticating using either Secrets Manager or temporary
    /// credentials.
    cluster_identifier: ?[]const u8 = null,

    /// A database name. The connected database is specified when you connect with
    /// your authentication credentials.
    connected_database: ?[]const u8 = null,

    /// The name of the database that contains the tables to list. If
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

    /// A pattern to filter results by schema name. Within a schema pattern, "%"
    /// means match any substring of 0 or more characters and "_" means match any
    /// one character. Only schema name entries matching the search pattern are
    /// returned. If `SchemaPattern` is not specified, then all tables that match
    /// `TablePattern` are returned. If neither `SchemaPattern` or `TablePattern`
    /// are specified, then all tables are returned.
    schema_pattern: ?[]const u8 = null,

    /// The name or ARN of the secret that enables access to the database. This
    /// parameter is required when authenticating using Secrets Manager.
    secret_arn: ?[]const u8 = null,

    /// A pattern to filter results by table name. Within a table pattern, "%" means
    /// match any substring of 0 or more characters and "_" means match any one
    /// character. Only table name entries matching the search pattern are returned.
    /// If `TablePattern` is not specified, then all tables that match
    /// `SchemaPattern`are returned. If neither `SchemaPattern` or `TablePattern`
    /// are specified, then all tables are returned.
    table_pattern: ?[]const u8 = null,

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
        .schema_pattern = "SchemaPattern",
        .secret_arn = "SecretArn",
        .table_pattern = "TablePattern",
        .workgroup_name = "WorkgroupName",
    };
};

pub const ListTablesOutput = struct {
    /// A value that indicates the starting point for the next set of response
    /// records in a subsequent request. If a value is returned in a response, you
    /// can retrieve the next set of records by providing this returned NextToken
    /// value in the next NextToken parameter and retrying the command. If the
    /// NextToken field is empty, all response records have been retrieved for the
    /// request.
    next_token: ?[]const u8 = null,

    /// The tables that match the request pattern.
    tables: ?[]const TableMember = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tables = "Tables",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTablesInput, options: Options) !ListTablesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "redshiftdata");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListTablesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshiftdata", "Redshift Data", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftData.ListTables");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTablesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTablesOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
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
        return .{ .arena = arena, .kind = .{ .active_sessions_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ActiveStatementsExceededException")) {
        return .{ .arena = arena, .kind = .{ .active_statements_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BatchExecuteStatementException")) {
        return .{ .arena = arena, .kind = .{ .batch_execute_statement_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DatabaseConnectionException")) {
        return .{ .arena = arena, .kind = .{ .database_connection_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExecuteStatementException")) {
        return .{ .arena = arena, .kind = .{ .execute_statement_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .query_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
