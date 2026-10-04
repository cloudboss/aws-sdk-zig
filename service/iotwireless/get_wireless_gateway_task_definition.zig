const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateWirelessGatewayTaskCreate = @import("update_wireless_gateway_task_create.zig").UpdateWirelessGatewayTaskCreate;

pub const GetWirelessGatewayTaskDefinitionInput = struct {
    /// The ID of the resource to get.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub const GetWirelessGatewayTaskDefinitionOutput = struct {
    /// The Amazon Resource Name of the resource.
    arn: ?[]const u8 = null,

    /// Whether to automatically create tasks using this task definition for all
    /// gateways with
    /// the specified current version. If `false`, the task must me created by
    /// calling `CreateWirelessGatewayTask`.
    auto_create_tasks: ?bool = null,

    /// The name of the resource.
    name: ?[]const u8 = null,

    /// Information about the gateways to update.
    update: ?UpdateWirelessGatewayTaskCreate = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .auto_create_tasks = "AutoCreateTasks",
        .name = "Name",
        .update = "Update",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWirelessGatewayTaskDefinitionInput, options: CallOptions) !GetWirelessGatewayTaskDefinitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWirelessGatewayTaskDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/wireless-gateway-task-definitions/");
    try path_buf.appendSlice(allocator, input.id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWirelessGatewayTaskDefinitionOutput {
    var result: GetWirelessGatewayTaskDefinitionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetWirelessGatewayTaskDefinitionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
