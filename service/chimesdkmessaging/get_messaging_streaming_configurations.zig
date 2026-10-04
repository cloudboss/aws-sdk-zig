const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamingConfiguration = @import("streaming_configuration.zig").StreamingConfiguration;

pub const GetMessagingStreamingConfigurationsInput = struct {
    /// The ARN of the streaming configurations.
    app_instance_arn: []const u8,

    pub const json_field_names = .{
        .app_instance_arn = "AppInstanceArn",
    };
};

pub const GetMessagingStreamingConfigurationsOutput = struct {
    /// The streaming settings.
    streaming_configurations: ?[]const StreamingConfiguration = null,

    pub const json_field_names = .{
        .streaming_configurations = "StreamingConfigurations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMessagingStreamingConfigurationsInput, options: CallOptions) !GetMessagingStreamingConfigurationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMessagingStreamingConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("messaging-chime", "Chime SDK Messaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/app-instances/");
    try path_buf.appendSlice(allocator, input.app_instance_arn);
    try path_buf.appendSlice(allocator, "/streaming-configurations");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMessagingStreamingConfigurationsOutput {
    var result: GetMessagingStreamingConfigurationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetMessagingStreamingConfigurationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
