const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WirelessGatewayTaskStatus = @import("wireless_gateway_task_status.zig").WirelessGatewayTaskStatus;

pub const CreateWirelessGatewayTaskInput = struct {
    /// The ID of the resource to update.
    id: []const u8,

    /// The ID of the WirelessGatewayTaskDefinition.
    wireless_gateway_task_definition_id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
        .wireless_gateway_task_definition_id = "WirelessGatewayTaskDefinitionId",
    };
};

pub const CreateWirelessGatewayTaskOutput = struct {
    /// The status of the request.
    status: ?WirelessGatewayTaskStatus = null,

    /// The ID of the WirelessGatewayTaskDefinition.
    wireless_gateway_task_definition_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "Status",
        .wireless_gateway_task_definition_id = "WirelessGatewayTaskDefinitionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWirelessGatewayTaskInput, options: CallOptions) !CreateWirelessGatewayTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWirelessGatewayTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/wireless-gateways/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/tasks");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"WirelessGatewayTaskDefinitionId\":");
    try aws.json.writeValue(@TypeOf(input.wireless_gateway_task_definition_id), input.wireless_gateway_task_definition_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWirelessGatewayTaskOutput {
    const result: CreateWirelessGatewayTaskOutput = try aws.json.parseJsonObject(
        CreateWirelessGatewayTaskOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
