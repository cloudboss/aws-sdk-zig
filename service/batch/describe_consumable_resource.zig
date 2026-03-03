const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const DescribeConsumableResourceInput = struct {
    /// The name or ARN of the consumable resource whose description will be
    /// returned.
    consumable_resource: []const u8,

    pub const json_field_names = .{
        .consumable_resource = "consumableResource",
    };
};

pub const DescribeConsumableResourceOutput = struct {
    /// The amount of the consumable resource that is currently available to use.
    available_quantity: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the consumable resource.
    consumable_resource_arn: []const u8,

    /// The name of the consumable resource.
    consumable_resource_name: []const u8,

    /// The Unix timestamp (in milliseconds) for when the consumable resource was
    /// created.
    created_at: ?i64 = null,

    /// The amount of the consumable resource that is currently in use.
    in_use_quantity: ?i64 = null,

    /// Indicates whether the resource is available to be re-used after a job
    /// completes. Can be
    /// one of:
    ///
    /// * `REPLENISHABLE`
    ///
    /// * `NON_REPLENISHABLE`
    resource_type: ?[]const u8 = null,

    /// The tags that you apply to the consumable resource to help you categorize
    /// and organize your
    /// resources. Each tag consists of a key and an optional value. For more
    /// information, see [Tagging your Batch
    /// resources](https://docs.aws.amazon.com/batch/latest/userguide/using-tags.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The total amount of the consumable resource that is available.
    total_quantity: ?i64 = null,

    pub const json_field_names = .{
        .available_quantity = "availableQuantity",
        .consumable_resource_arn = "consumableResourceArn",
        .consumable_resource_name = "consumableResourceName",
        .created_at = "createdAt",
        .in_use_quantity = "inUseQuantity",
        .resource_type = "resourceType",
        .tags = "tags",
        .total_quantity = "totalQuantity",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConsumableResourceInput, options: CallOptions) !DescribeConsumableResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "batch");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConsumableResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/describeconsumableresource";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"consumableResource\":");
    try aws.json.writeValue(@TypeOf(input.consumable_resource), input.consumable_resource, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConsumableResourceOutput {
    var result: DescribeConsumableResourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeConsumableResourceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "ClientException")) {
        return .{ .arena = arena, .kind = .{ .client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerException")) {
        return .{ .arena = arena, .kind = .{ .server_exception = .{
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
