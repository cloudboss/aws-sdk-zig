const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotifyCodeConfiguration = @import("notify_code_configuration.zig").NotifyCodeConfiguration;

pub const GetNotifyCodeConfigurationInput = struct {
    /// The unique identifier of the notify code configuration. You can specify
    /// either the bare ID or the full Amazon Resource Name (ARN).
    notify_code_configuration_id: []const u8,

    pub const json_field_names = .{
        .notify_code_configuration_id = "notifyCodeConfigurationId",
    };
};

pub const GetNotifyCodeConfigurationOutput = struct {
    /// The notify code configuration resource.
    notify_code_configuration: ?NotifyCodeConfiguration = null,

    pub const json_field_names = .{
        .notify_code_configuration = "notifyCodeConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetNotifyCodeConfigurationInput, options: CallOptions) !GetNotifyCodeConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "end-user-messaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetNotifyCodeConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("end-user-messaging", "EndUserMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/notify-code-configurations/");
    try path_buf.appendSlice(allocator, input.notify_code_configuration_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetNotifyCodeConfigurationOutput {
    const result: GetNotifyCodeConfigurationOutput = try aws.json.parseJsonObject(
        GetNotifyCodeConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
