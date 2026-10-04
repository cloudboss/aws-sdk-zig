const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutHubConfigurationInput = struct {
    /// A user-defined integer value that represents the hub token timer expiry
    /// setting in seconds.
    hub_token_timer_expiry_setting_in_seconds: i64,

    pub const json_field_names = .{
        .hub_token_timer_expiry_setting_in_seconds = "HubTokenTimerExpirySettingInSeconds",
    };
};

pub const PutHubConfigurationOutput = struct {
    /// A user-defined integer value that represents the hub token timer expiry
    /// setting in seconds.
    hub_token_timer_expiry_setting_in_seconds: ?i64 = null,

    pub const json_field_names = .{
        .hub_token_timer_expiry_setting_in_seconds = "HubTokenTimerExpirySettingInSeconds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutHubConfigurationInput, options: CallOptions) !PutHubConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutHubConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/hub-configuration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"HubTokenTimerExpirySettingInSeconds\":");
    try aws.json.writeValue(@TypeOf(input.hub_token_timer_expiry_setting_in_seconds), input.hub_token_timer_expiry_setting_in_seconds, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutHubConfigurationOutput {
    const result: PutHubConfigurationOutput = try aws.json.parseJsonObject(
        PutHubConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
