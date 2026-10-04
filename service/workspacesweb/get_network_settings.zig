const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NetworkSettings = @import("network_settings.zig").NetworkSettings;

pub const GetNetworkSettingsInput = struct {
    /// The ARN of the network settings.
    network_settings_arn: []const u8,

    pub const json_field_names = .{
        .network_settings_arn = "networkSettingsArn",
    };
};

pub const GetNetworkSettingsOutput = struct {
    /// The network settings.
    network_settings: ?NetworkSettings = null,

    pub const json_field_names = .{
        .network_settings = "networkSettings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetNetworkSettingsInput, options: CallOptions) !GetNetworkSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces-web", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetNetworkSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces-web", "WorkSpaces Web", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networkSettings/");
    try path_buf.appendSlice(allocator, input.network_settings_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetNetworkSettingsOutput {
    var result: GetNetworkSettingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetNetworkSettingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
