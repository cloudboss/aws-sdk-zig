const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WirelessGatewayTaskStatus = @import("wireless_gateway_task_status.zig").WirelessGatewayTaskStatus;

pub const GetWirelessGatewayTaskInput = struct {
    /// The ID of the resource to get.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub const GetWirelessGatewayTaskOutput = struct {
    /// The date and time when the most recent uplink was received.
    ///
    /// This value is only valid for 3 months.
    last_uplink_received_at: ?[]const u8 = null,

    /// The status of the request.
    status: ?WirelessGatewayTaskStatus = null,

    /// The date and time when the task was created.
    task_created_at: ?[]const u8 = null,

    /// The ID of the wireless gateway.
    wireless_gateway_id: ?[]const u8 = null,

    /// The ID of the WirelessGatewayTask.
    wireless_gateway_task_definition_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_uplink_received_at = "LastUplinkReceivedAt",
        .status = "Status",
        .task_created_at = "TaskCreatedAt",
        .wireless_gateway_id = "WirelessGatewayId",
        .wireless_gateway_task_definition_id = "WirelessGatewayTaskDefinitionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWirelessGatewayTaskInput, options: CallOptions) !GetWirelessGatewayTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotwireless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWirelessGatewayTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/wireless-gateways/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/tasks");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWirelessGatewayTaskOutput {
    var result: GetWirelessGatewayTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetWirelessGatewayTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
