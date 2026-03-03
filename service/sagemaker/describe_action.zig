const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const UserContext = @import("user_context.zig").UserContext;
const MetadataProperties = @import("metadata_properties.zig").MetadataProperties;
const ActionSource = @import("action_source.zig").ActionSource;
const ActionStatus = @import("action_status.zig").ActionStatus;

pub const DescribeActionInput = struct {
    /// The name of the action to describe.
    action_name: []const u8,

    pub const json_field_names = .{
        .action_name = "ActionName",
    };
};

pub const DescribeActionOutput = struct {
    /// The Amazon Resource Name (ARN) of the action.
    action_arn: ?[]const u8 = null,

    /// The name of the action.
    action_name: ?[]const u8 = null,

    /// The type of the action.
    action_type: ?[]const u8 = null,

    created_by: ?UserContext = null,

    /// When the action was created.
    creation_time: ?i64 = null,

    /// The description of the action.
    description: ?[]const u8 = null,

    last_modified_by: ?UserContext = null,

    /// When the action was last modified.
    last_modified_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the lineage group.
    lineage_group_arn: ?[]const u8 = null,

    metadata_properties: ?MetadataProperties = null,

    /// A list of the action's properties.
    properties: ?[]const aws.map.StringMapEntry = null,

    /// The source of the action.
    source: ?ActionSource = null,

    /// The status of the action.
    status: ?ActionStatus = null,

    pub const json_field_names = .{
        .action_arn = "ActionArn",
        .action_name = "ActionName",
        .action_type = "ActionType",
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .description = "Description",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .lineage_group_arn = "LineageGroupArn",
        .metadata_properties = "MetadataProperties",
        .properties = "Properties",
        .source = "Source",
        .status = "Status",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeActionInput, options: Options) !DescribeActionOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeAction");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeActionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeActionOutput, body, allocator);
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
