const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const HubStatus = @import("hub_status.zig").HubStatus;
const HubS3StorageConfig = @import("hub_s3_storage_config.zig").HubS3StorageConfig;

pub const DescribeHubInput = struct {
    /// The name of the hub to describe.
    hub_name: []const u8,

    pub const json_field_names = .{
        .hub_name = "HubName",
    };
};

pub const DescribeHubOutput = struct {
    /// The date and time that the hub was created.
    creation_time: i64,

    /// The failure reason if importing hub content failed.
    failure_reason: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the hub.
    hub_arn: []const u8,

    /// A description of the hub.
    hub_description: ?[]const u8 = null,

    /// The display name of the hub.
    hub_display_name: ?[]const u8 = null,

    /// The name of the hub.
    hub_name: []const u8,

    /// The searchable keywords for the hub.
    hub_search_keywords: ?[]const []const u8 = null,

    /// The status of the hub.
    hub_status: HubStatus,

    /// The date and time that the hub was last modified.
    last_modified_time: i64,

    /// The Amazon S3 storage configuration for the hub.
    s3_storage_config: ?HubS3StorageConfig = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .hub_arn = "HubArn",
        .hub_description = "HubDescription",
        .hub_display_name = "HubDisplayName",
        .hub_name = "HubName",
        .hub_search_keywords = "HubSearchKeywords",
        .hub_status = "HubStatus",
        .last_modified_time = "LastModifiedTime",
        .s3_storage_config = "S3StorageConfig",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeHubInput, options: Options) !DescribeHubOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeHubInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.DescribeHub");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeHubOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeHubOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
