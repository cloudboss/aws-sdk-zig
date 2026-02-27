const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PayloadFormatIndicator = @import("payload_format_indicator.zig").PayloadFormatIndicator;

pub const PublishInput = struct {
    /// A UTF-8 encoded string that describes the content of the publishing message.
    content_type: ?[]const u8 = null,

    /// The base64-encoded binary data used by the sender of the request message to
    /// identify which
    /// request the response message is for when it's received. `correlationData` is
    /// an
    /// HTTP header value in the API.
    correlation_data: ?[]const u8 = null,

    /// A user-defined integer value that represents the message expiry interval in
    /// seconds. If
    /// absent, the message doesn't expire. For more information about the limits of
    /// `messageExpiry`, see [Amazon Web Services IoT Core message broker and
    /// protocol limits and quotas
    /// ](https://docs.aws.amazon.com/general/latest/gr/iot-core.html#message-broker-limits) from the Amazon Web Services Reference Guide.
    message_expiry: i64 = 0,

    /// The message body. MQTT accepts text, binary, and empty (null) message
    /// payloads.
    ///
    /// Publishing an empty (null) payload with **retain** =
    /// `true` deletes the retained message identified by **topic** from Amazon Web
    /// Services IoT Core.
    payload: ?[]const u8 = null,

    /// An `Enum` string value that indicates whether the payload is formatted as
    /// UTF-8. `payloadFormatIndicator` is an HTTP header value in the API.
    payload_format_indicator: ?PayloadFormatIndicator = null,

    /// The Quality of Service (QoS) level. The default QoS level is 0.
    qos: i32 = 0,

    /// A UTF-8 encoded string that's used as the topic name for a response message.
    /// The response
    /// topic is used to describe the topic which the receiver should publish to as
    /// part of the
    /// request-response flow. The topic must not contain wildcard characters.
    response_topic: ?[]const u8 = null,

    /// A Boolean value that determines whether to set the RETAIN flag when the
    /// message is published.
    ///
    /// Setting the RETAIN flag causes the message to be retained and sent to new
    /// subscribers to the topic.
    ///
    /// Valid values: `true` | `false`
    ///
    /// Default value: `false`
    retain: bool = false,

    /// The name of the MQTT topic.
    topic: []const u8,

    /// A JSON string that contains an array of JSON objects. If you don’t use
    /// Amazon Web Services SDK or CLI,
    /// you must encode the JSON string to base64 format before adding it to the
    /// HTTP header.
    /// `userProperties` is an HTTP header value in the API.
    ///
    /// The following example `userProperties` parameter is a JSON string which
    /// represents two User Properties. Note that it needs to be base64-encoded:
    ///
    /// `[{"deviceName": "alpha"}, {"deviceCnt": "45"}]`
    user_properties: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_type = "contentType",
        .correlation_data = "correlationData",
        .message_expiry = "messageExpiry",
        .payload = "payload",
        .payload_format_indicator = "payloadFormatIndicator",
        .qos = "qos",
        .response_topic = "responseTopic",
        .retain = "retain",
        .topic = "topic",
        .user_properties = "userProperties",
    };
};

const PublishOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PublishInput, options: Options) !PublishOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iotdataplane");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: PublishInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotdataplane", "IoT Data Plane", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/topics/");
    try path_buf.appendSlice(alloc, input.topic);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.content_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "contentType=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.message_expiry) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "messageExpiry=");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try query_buf.appendSlice(alloc, num_str);
        }
        query_has_prev = true;
    }
    if (input.qos) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "qos=");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try query_buf.appendSlice(alloc, num_str);
        }
        query_has_prev = true;
    }
    if (input.response_topic) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "responseTopic=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.retain) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "retain=");
        try query_buf.appendSlice(alloc, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    const body = input.payload orelse "";

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");
    if (input.correlation_data) |v| {
        try request.headers.put(alloc, "x-amz-mqtt5-correlation-data", v);
    }
    if (input.payload_format_indicator) |v| {
        try request.headers.put(alloc, "x-amz-mqtt5-payload-format-indicator", @tagName(v));
    }
    if (input.user_properties) |v| {
        try request.headers.put(alloc, "x-amz-mqtt5-user-properties", v);
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PublishOutput {
    _ = alloc;
    _ = body;
    _ = status;
    _ = headers;
    const result: PublishOutput = .{};

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MethodNotAllowedException")) {
        return .{ .arena = arena, .kind = .{ .method_not_allowed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestEntityTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .request_entity_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedDocumentEncodingException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_document_encoding_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
