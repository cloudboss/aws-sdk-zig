const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DisconnectReasonValue = @import("disconnect_reason_value.zig").DisconnectReasonValue;

pub const GetThingConnectivityDataInput = struct {
    /// Specifies if socket information (sourcePort, targetPort, sourceIp, targetIp,
    /// vpcEndpointId) should be included in the GetThingConnectivityData response.
    /// Set to `true` to include socket information. Set to `false` to omit socket
    /// information. By default, this is set to `false`.
    include_socket_information: ?bool = null,

    /// The name of your IoT thing.
    thing_name: []const u8,

    pub const json_field_names = .{
        .include_socket_information = "includeSocketInformation",
        .thing_name = "thingName",
    };
};

pub const GetThingConnectivityDataOutput = struct {
    /// Indicates whether the client is using a clean session. Returns `true` for
    /// clean sessions.
    clean_session: ?bool = null,

    /// The unique identifier of the MQTT client.
    client_id: ?[]const u8 = null,

    /// A Boolean that indicates the connectivity status.
    connected: ?bool = null,

    /// The reason that the client is disconnected.
    disconnect_reason: ?DisconnectReasonValue = null,

    /// The keep-alive interval in seconds that the client specified when
    /// establishing the connection.
    keep_alive_duration: ?i32 = null,

    /// The session expiry interval in seconds for the MQTT client connection. This
    /// value indicates how long the session will remain active after the client
    /// disconnects.
    session_expiry: ?i64 = null,

    /// The IP address of the client that initiated the connection.
    source_ip: ?[]const u8 = null,

    /// The client's source port.
    source_port: ?i32 = null,

    /// The IP address of the Amazon Web Services IoT Core endpoint that the client
    /// connected to.
    target_ip: ?[]const u8 = null,

    /// The port number of the Amazon Web Services IoT Core endpoint that the client
    /// connected to.
    target_port: ?i32 = null,

    /// The name of your IoT thing.
    thing_name: ?[]const u8 = null,

    /// The timestamp of when the device connected or disconnected.
    timestamp: ?i64 = null,

    /// The ID of the VPC endpoint. Present for clients connected to Amazon Web
    /// Services IoT Core via a VPC endpoint.
    vpc_endpoint_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .clean_session = "cleanSession",
        .client_id = "clientId",
        .connected = "connected",
        .disconnect_reason = "disconnectReason",
        .keep_alive_duration = "keepAliveDuration",
        .session_expiry = "sessionExpiry",
        .source_ip = "sourceIp",
        .source_port = "sourcePort",
        .target_ip = "targetIp",
        .target_port = "targetPort",
        .thing_name = "thingName",
        .timestamp = "timestamp",
        .vpc_endpoint_id = "vpcEndpointId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetThingConnectivityDataInput, options: CallOptions) !GetThingConnectivityDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetThingConnectivityDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/things/");
    try path_buf.appendSlice(allocator, input.thing_name);
    try path_buf.appendSlice(allocator, "/connectivity-data");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.include_socket_information) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"includeSocketInformation\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetThingConnectivityDataOutput {
    const result: GetThingConnectivityDataOutput = try aws.json.parseJsonObject(
        GetThingConnectivityDataOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
