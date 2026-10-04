const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchDeviceErrorResponseItem = @import("batch_device_error_response_item.zig").BatchDeviceErrorResponseItem;
const BatchDeviceSuccessResponseItem = @import("batch_device_success_response_item.zig").BatchDeviceSuccessResponseItem;

pub const BatchResetDevicesForUserInput = struct {
    /// A list of application IDs identifying the specific devices to be reset for
    /// the user. Maximum 50 devices per batch request.
    app_ids: []const []const u8,

    /// A unique identifier for this request to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// The ID of the Wickr network containing the user whose devices will be reset.
    network_id: []const u8,

    /// The ID of the user whose devices will be reset.
    user_id: []const u8,

    pub const json_field_names = .{
        .app_ids = "appIds",
        .client_token = "clientToken",
        .network_id = "networkId",
        .user_id = "userId",
    };
};

pub const BatchResetDevicesForUserOutput = struct {
    /// A list of device reset attempts that failed, including error details
    /// explaining why each device could not be reset.
    failed: ?[]const BatchDeviceErrorResponseItem = null,

    /// A message indicating the overall result of the batch device reset operation.
    message: ?[]const u8 = null,

    /// A list of application IDs that were successfully reset.
    successful: ?[]const BatchDeviceSuccessResponseItem = null,

    pub const json_field_names = .{
        .failed = "failed",
        .message = "message",
        .successful = "successful",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchResetDevicesForUserInput, options: CallOptions) !BatchResetDevicesForUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wickr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchResetDevicesForUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("admin.wickr", "Wickr", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/users/");
    try path_buf.appendSlice(allocator, input.user_id);
    try path_buf.appendSlice(allocator, "/devices");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"appIds\":");
    try aws.json.writeValue(@TypeOf(input.app_ids), input.app_ids, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.client_token) |v| {
        try request.headers.put(allocator, "X-Client-Token", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchResetDevicesForUserOutput {
    var result: BatchResetDevicesForUserOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchResetDevicesForUserOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
