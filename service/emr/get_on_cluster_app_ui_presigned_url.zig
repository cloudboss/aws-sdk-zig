const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const OnClusterAppUIType = @import("on_cluster_app_ui_type.zig").OnClusterAppUIType;

pub const GetOnClusterAppUIPresignedURLInput = struct {
    /// The application ID associated with the cluster's application user interface
    /// presigned URL.
    application_id: ?[]const u8 = null,

    /// The cluster ID associated with the cluster's application user interface
    /// presigned URL.
    cluster_id: []const u8,

    /// Determines if the user interface presigned URL is for a dry run.
    dry_run: ?bool = null,

    /// The execution role ARN associated with the cluster's application user
    /// interface
    /// presigned URL.
    execution_role_arn: ?[]const u8 = null,

    /// The application UI type associated with the cluster's application user
    /// interface presigned URL.
    on_cluster_app_ui_type: ?OnClusterAppUIType = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .cluster_id = "ClusterId",
        .dry_run = "DryRun",
        .execution_role_arn = "ExecutionRoleArn",
        .on_cluster_app_ui_type = "OnClusterAppUIType",
    };
};

pub const GetOnClusterAppUIPresignedURLOutput = struct {
    /// The cluster's generated presigned URL.
    presigned_url: ?[]const u8 = null,

    /// Used to determine if the presigned URL is ready.
    presigned_url_ready: ?bool = null,

    pub const json_field_names = .{
        .presigned_url = "PresignedURL",
        .presigned_url_ready = "PresignedURLReady",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOnClusterAppUIPresignedURLInput, options: Options) !GetOnClusterAppUIPresignedURLOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "emr");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOnClusterAppUIPresignedURLInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("emr", "EMR", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.GetOnClusterAppUIPresignedURL");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOnClusterAppUIPresignedURLOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetOnClusterAppUIPresignedURLOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
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
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
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
