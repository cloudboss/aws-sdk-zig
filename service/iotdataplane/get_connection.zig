const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetConnectionInput = struct {
    /// The unique identifier of the MQTT client to retrieve connection information.
    /// The client ID can't start with a dollar sign ($).
    ///
    /// MQTT client IDs must be URL encoded (percent-encoded) when they contain
    /// characters that are not valid in HTTP requests, such as spaces, forward
    /// slashes (/), and UTF-8 characters.
    client_id: []const u8,

    /// Specifies if socket information (sourcePort, targetPort, sourceIp, targetIp)
    /// should be included in the GetConnection response. Set to `TRUE` to include
    /// socket information. Set to `FALSE` to omit socket information. By default,
    /// this is set to `FALSE`. See the [developer
    /// guide](https://docs.aws.amazon.com/iot/latest/developerguide/mqtt.html#mqtt-client-disconnect) for how to authorize this parameter.
    include_socket_information: ?bool = null,

    pub const json_field_names = .{
        .client_id = "clientId",
        .include_socket_information = "includeSocketInformation",
    };
};

pub const GetConnectionOutput = struct {
    /// Indicates whether the client is using a clean session. Returns `true` for
    /// clean sessions or `false` for persistent sessions.
    clean_session: ?bool = null,

    /// The unique identifier of the MQTT client. This is the same client ID that
    /// was used when the client established the connection.
    client_id: ?[]const u8 = null,

    /// The connection state of the client. Returns `true` if the client is
    /// currently connected, or `false` if the client is not connected.
    connected: ?bool = null,

    /// Unix timestamp (in milliseconds) indicating when the client connected.
    /// Present only when connected is true.
    connected_since: ?i64 = null,

    /// Unix timestamp (in milliseconds) indicating when the client disconnected.
    /// Present only when connected is false. This information is available for 30
    /// minutes after the client disconnects.
    disconnected_since: ?i64 = null,

    /// The reason for the last disconnection, if the client is currently
    /// disconnected. See the [developer
    /// guide](https://docs.aws.amazon.com/iot/latest/developerguide/life-cycle-events.html#connect-disconnect) for valid disconnect reasons.
    disconnect_reason: ?[]const u8 = null,

    /// The keep-alive interval in seconds that the client specified when
    /// establishing the connection.
    keep_alive_duration: ?i32 = null,

    /// The session expiry interval in seconds for the MQTT client connection. This
    /// is configured by the user. This value indicates how long the session will
    /// remain active after the client disconnects.
    session_expiry: ?i64 = null,

    /// The IP address of the client that initiated the connection.
    source_ip: ?[]const u8 = null,

    /// The client's source port.
    source_port: ?i32 = null,

    /// The IP address of the Amazon Web Services IoT Core endpoint that the client
    /// connected to. For clients connected to VPC endpoints, this is the private IP
    /// address of the network interface the client is connected to.
    target_ip: ?[]const u8 = null,

    /// The port number of the Amazon Web Services IoT Core endpoint that the client
    /// connected to.
    target_port: ?i32 = null,

    /// The name of the thing associated with the principal of the MQTT client, if
    /// applicable.
    thing_name: ?[]const u8 = null,

    /// The ID of the VPC endpoint. Present for clients connected to IoT Core via a
    /// [VPC
    /// endpoint](https://docs.aws.amazon.com/iot/latest/developerguide/IoTCore-VPC.html).
    vpc_endpoint_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .clean_session = "cleanSession",
        .client_id = "clientId",
        .connected = "connected",
        .connected_since = "connectedSince",
        .disconnected_since = "disconnectedSince",
        .disconnect_reason = "disconnectReason",
        .keep_alive_duration = "keepAliveDuration",
        .session_expiry = "sessionExpiry",
        .source_ip = "sourceIp",
        .source_port = "sourcePort",
        .target_ip = "targetIp",
        .target_port = "targetPort",
        .thing_name = "thingName",
        .vpc_endpoint_id = "vpcEndpointId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConnectionInput, options: CallOptions) !GetConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data-ats.iot", "IoT Data Plane", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/connections/");
    try path_buf.appendSlice(allocator, input.client_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.include_socket_information) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeSocketInformation=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConnectionOutput {
    const result: GetConnectionOutput = try aws.json.parseJsonObject(
        GetConnectionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
