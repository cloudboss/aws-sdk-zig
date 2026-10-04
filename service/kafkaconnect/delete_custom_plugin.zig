const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomPluginState = @import("custom_plugin_state.zig").CustomPluginState;

pub const DeleteCustomPluginInput = struct {
    /// The Amazon Resource Name (ARN) of the custom plugin that you want to delete.
    custom_plugin_arn: []const u8,

    pub const json_field_names = .{
        .custom_plugin_arn = "customPluginArn",
    };
};

pub const DeleteCustomPluginOutput = struct {
    /// The Amazon Resource Name (ARN) of the custom plugin that you requested to
    /// delete.
    custom_plugin_arn: ?[]const u8 = null,

    /// The state of the custom plugin.
    custom_plugin_state: ?CustomPluginState = null,

    pub const json_field_names = .{
        .custom_plugin_arn = "customPluginArn",
        .custom_plugin_state = "customPluginState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteCustomPluginInput, options: CallOptions) !DeleteCustomPluginOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafkaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteCustomPluginInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafkaconnect", "KafkaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/custom-plugins/");
    try path_buf.appendSlice(allocator, input.custom_plugin_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteCustomPluginOutput {
    const result: DeleteCustomPluginOutput = try aws.json.parseJsonObject(
        DeleteCustomPluginOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
