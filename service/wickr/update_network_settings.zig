const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NetworkSettings = @import("network_settings.zig").NetworkSettings;
const Setting = @import("setting.zig").Setting;

pub const UpdateNetworkSettingsInput = struct {
    /// The ID of the Wickr network whose settings will be updated.
    network_id: []const u8,

    /// A map of setting names to their new values. Each setting should be provided
    /// with its appropriate type (boolean, string, number, etc.).
    settings: NetworkSettings,

    pub const json_field_names = .{
        .network_id = "networkId",
        .settings = "settings",
    };
};

pub const UpdateNetworkSettingsOutput = struct {
    /// A list of the updated network settings, showing the new values for each
    /// modified setting.
    settings: ?[]const Setting = null,

    pub const json_field_names = .{
        .settings = "settings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateNetworkSettingsInput, options: CallOptions) !UpdateNetworkSettingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateNetworkSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("admin.wickr", "Wickr", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/settings");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"settings\":");
    try aws.json.writeValue(@TypeOf(input.settings), input.settings, allocator, &body_buf);
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateNetworkSettingsOutput {
    var result: UpdateNetworkSettingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateNetworkSettingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
