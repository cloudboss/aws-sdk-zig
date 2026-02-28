const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const OpenTableFormat = @import("open_table_format.zig").OpenTableFormat;
const ManagedTableInformation = @import("managed_table_information.zig").ManagedTableInformation;
const TableType = @import("table_type.zig").TableType;

pub const GetTableInput = struct {
    /// The name of the table.
    name: ?[]const u8 = null,

    /// The name of the namespace the table is associated with.
    namespace: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the table.
    table_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the table bucket associated with the
    /// table.
    table_bucket_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .namespace = "namespace",
        .table_arn = "tableArn",
        .table_bucket_arn = "tableBucketARN",
    };
};

pub const GetTableOutput = struct {
    /// The date and time the table bucket was created at.
    created_at: i64,

    /// The ID of the account that created the table.
    created_by: []const u8,

    /// The format of the table.
    format: OpenTableFormat,

    /// The service that manages the table.
    managed_by_service: ?[]const u8 = null,

    /// If this table is managed by S3 Tables, contains additional information such
    /// as replication details.
    managed_table_information: ?ManagedTableInformation = null,

    /// The metadata location of the table.
    metadata_location: ?[]const u8 = null,

    /// The date and time the table was last modified on.
    modified_at: i64,

    /// The ID of the account that last modified the table.
    modified_by: []const u8,

    /// The name of the table.
    name: []const u8,

    /// The namespace associated with the table.
    namespace: ?[]const []const u8 = null,

    /// The unique identifier of the namespace containing this table.
    namespace_id: ?[]const u8 = null,

    /// The ID of the account that owns the table.
    owner_account_id: []const u8,

    /// The Amazon Resource Name (ARN) of the table.
    table_arn: []const u8,

    /// The unique identifier of the table bucket containing this table.
    table_bucket_id: ?[]const u8 = null,

    /// The type of the table.
    @"type": TableType,

    /// The version token of the table.
    version_token: []const u8,

    /// The warehouse location of the table.
    warehouse_location: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .format = "format",
        .managed_by_service = "managedByService",
        .managed_table_information = "managedTableInformation",
        .metadata_location = "metadataLocation",
        .modified_at = "modifiedAt",
        .modified_by = "modifiedBy",
        .name = "name",
        .namespace = "namespace",
        .namespace_id = "namespaceId",
        .owner_account_id = "ownerAccountId",
        .table_arn = "tableARN",
        .table_bucket_id = "tableBucketId",
        .@"type" = "type",
        .version_token = "versionToken",
        .warehouse_location = "warehouseLocation",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTableInput, options: Options) !GetTableOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "s3tables");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3tables", "S3Tables", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/get-table";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.name) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "name=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.namespace) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "namespace=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.table_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "tableArn=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.table_bucket_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "tableBucketARN=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetTableOutput {
    var result: GetTableOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTableOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MethodNotAllowedException")) {
        return .{ .arena = arena, .kind = .{ .method_not_allowed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
