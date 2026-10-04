const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteConnectionInput = struct {
    /// Specifies whether to remove the client's persistent session state when
    /// disconnecting. Set to `TRUE` to delete all session information, including
    /// subscriptions and queued messages. Set to `FALSE` to preserve the session
    /// state for [persistent
    /// sessions](https://docs.aws.amazon.com/iot/latest/developerguide/mqtt.html#mqtt-persistent-sessions). For clean sessions this parameter will be ignored. By default, this is set to `FALSE` (preserves the session state).
    clean_session: ?bool = null,

    /// The unique identifier of the MQTT client to disconnect. The client ID can't
    /// start with a dollar sign ($).
    ///
    /// MQTT client IDs must be URL encoded (percent-encoded) when they contain
    /// characters that are not valid in HTTP requests, such as spaces, forward
    /// slashes (/), and UTF-8 characters.
    client_id: []const u8,

    /// Controls if Amazon Web Services IoT Core publishes the client's Last Will
    /// and Testament (LWT) message upon disconnection. Set to `TRUE` to prevent
    /// publishing the LWT message. Set to `FALSE` to ensure that LWT is published.
    /// By default, this is set to `FALSE` (LWT message is published).
    prevent_will_message: ?bool = null,

    pub const json_field_names = .{
        .clean_session = "cleanSession",
        .client_id = "clientId",
        .prevent_will_message = "preventWillMessage",
    };
};

pub const DeleteConnectionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteConnectionInput, options: CallOptions) !DeleteConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotdata", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data-ats.iot", "IoT Data Plane", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/connections/");
    try path_buf.appendSlice(allocator, input.client_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.clean_session) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "cleanSession=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.prevent_will_message) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "preventWillMessage=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteConnectionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteConnectionOutput = .{};

    return result;
}
