const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const UpdateConsumableResourceInput = struct {
    /// If this parameter is specified and two update requests with identical
    /// payloads and
    /// `clientToken`s are received, these requests are considered the same request.
    /// Both requests will succeed, but the update will only happen once. A
    /// `clientToken` is valid for 8 hours.
    client_token: ?[]const u8 = null,

    /// The name or ARN of the consumable resource to be updated.
    consumable_resource: []const u8,

    /// Indicates how the quantity of the consumable resource will be updated. Must
    /// be one of:
    ///
    /// * `SET`
    ///
    /// Sets the quantity of the resource to the value specified by the `quantity`
    /// parameter.
    ///
    /// * `ADD`
    ///
    /// Increases the quantity of the resource by the value specified by the
    /// `quantity`
    /// parameter.
    ///
    /// * `REMOVE`
    ///
    /// Reduces the quantity of the resource by the value specified by the
    /// `quantity`
    /// parameter.
    operation: ?[]const u8 = null,

    /// The change in the total quantity of the consumable resource. The `operation`
    /// parameter determines whether the value specified here will be the new total
    /// quantity, or
    /// the amount by which the total quantity will be increased or reduced. Must be
    /// a non-negative
    /// value.
    quantity: ?i64 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .consumable_resource = "consumableResource",
        .operation = "operation",
        .quantity = "quantity",
    };
};

pub const UpdateConsumableResourceOutput = struct {
    /// The Amazon Resource Name (ARN) of the consumable resource.
    consumable_resource_arn: []const u8,

    /// The name of the consumable resource to be updated.
    consumable_resource_name: []const u8,

    /// The total amount of the consumable resource that is available.
    total_quantity: ?i64 = null,

    pub const json_field_names = .{
        .consumable_resource_arn = "consumableResourceArn",
        .consumable_resource_name = "consumableResourceName",
        .total_quantity = "totalQuantity",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateConsumableResourceInput, options: CallOptions) !UpdateConsumableResourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateConsumableResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/updateconsumableresource";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"consumableResource\":");
    try aws.json.writeValue(@TypeOf(input.consumable_resource), input.consumable_resource, allocator, &body_buf);
    has_prev = true;
    if (input.operation) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"operation\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.quantity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"quantity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateConsumableResourceOutput {
    var result: UpdateConsumableResourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateConsumableResourceOutput, body, allocator);
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
