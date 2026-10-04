const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PayloadFormatIndicator = @import("payload_format_indicator.zig").PayloadFormatIndicator;

pub const SendDirectMessageInput = struct {
    /// The unique identifier of the MQTT client to send the message to.
    ///
    /// Client IDs must not exceed 128 characters and can't start with a dollar sign
    /// ($).
    /// MQTT client IDs must be URL encoded (percent-encoded) when they contain
    /// characters that are
    /// not valid in HTTP requests, such as spaces, forward slashes (/), and UTF-8
    /// characters.
    /// For more information, see [Amazon Web Services IoT Core message broker and
    /// protocol limits and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/iot-core.html#message-broker-limits).
    client_id: []const u8,

    /// A Boolean value that specifies whether to wait for delivery confirmation
    /// from the receiving client.
    ///
    /// When set to `true`, the API delivers the message at QoS 1 and waits for
    /// the client to send a delivery confirmation (PUBACK) before returning a
    /// successful response. If
    /// delivery confirmation is not received within the specified `timeout` period,
    /// the API returns HTTP 504.
    ///
    /// When set to `false`, the API delivers the message at QoS 0 and returns
    /// after Amazon Web Services IoT Core attempts to deliver the message.
    ///
    /// Valid values: `true` | `false`
    ///
    /// Default value: `false`
    confirmation: ?bool = null,

    /// The MQTT5 content type property forwarded to the receiving client
    /// (for example, `application/json`).
    content_type: ?[]const u8 = null,

    /// The base64-encoded binary data used by the sender of the request message to
    /// identify which
    /// request the response message is for when it's received. `correlationData` is
    /// an
    /// HTTP header value in the API.
    correlation_data: ?[]const u8 = null,

    /// The message body. MQTT accepts text, binary, and empty (null) message
    /// payloads.
    payload: ?[]const u8 = null,

    /// An `Enum` string value that indicates whether the payload is formatted as
    /// UTF-8. `payloadFormatIndicator` is an HTTP header value in the API.
    payload_format_indicator: ?PayloadFormatIndicator = null,

    /// A UTF-8 encoded string that's used as the topic name for a response message.
    /// The response
    /// topic describes the topic which the receiver should publish to as part of
    /// the
    /// request-response flow. The topic must not contain wildcard characters.
    /// For more information, see [Amazon Web Services IoT Core message broker and
    /// protocol limits and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/iot-core.html#message-broker-limits).
    response_topic: ?[]const u8 = null,

    /// An integer that represents the maximum time, in seconds, to wait for a
    /// delivery confirmation (PUBACK) from the
    /// receiving client after the message has been delivered. This parameter is
    /// only used when
    /// `confirmation` is set to `true`. If `confirmation`
    /// is `false`, this parameter is ignored.
    ///
    /// The total API response time may be higher than this value due to internal
    /// processing.
    /// Set your HTTP client timeout to a value greater than this parameter.
    ///
    /// Valid range: 1 to 15 seconds.
    ///
    /// Default value: `5` seconds.
    timeout: ?i32 = null,

    /// The topic of the outbound MQTT Publish message to the receiving client.
    /// For more information, see [Amazon Web Services IoT Core message broker and
    /// protocol limits and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/iot-core.html#message-broker-limits).
    topic: []const u8,

    /// A JSON string that contains an array of JSON objects. If you don't use
    /// Amazon Web Services SDK or CLI,
    /// you must encode the JSON string to base64 format before adding it to the
    /// HTTP header.
    /// `userProperties` is an HTTP header value in the API.
    ///
    /// For MQTT 3.1.1 clients, user properties are silently dropped.
    ///
    /// The following example `userProperties` parameter is a JSON string which
    /// represents two User Properties. Note that it needs to be base64-encoded:
    ///
    /// `[{"deviceName": "alpha"}, {"deviceCnt": "45"}]`
    user_properties: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_id = "clientId",
        .confirmation = "confirmation",
        .content_type = "contentType",
        .correlation_data = "correlationData",
        .payload = "payload",
        .payload_format_indicator = "payloadFormatIndicator",
        .response_topic = "responseTopic",
        .timeout = "timeout",
        .topic = "topic",
        .user_properties = "userProperties",
    };
};

pub const SendDirectMessageOutput = struct {
    /// The status message indicating the result of the operation.
    message: ?[]const u8 = null,

    /// A unique identifier for the request. Include this value when contacting
    /// Amazon Web Services Support for troubleshooting.
    trace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .trace_id = "traceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendDirectMessageInput, options: CallOptions) !SendDirectMessageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendDirectMessageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data-ats.iot", "IoT Data Plane", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/connections/");
    try path_buf.appendSlice(allocator, input.client_id);
    try path_buf.appendSlice(allocator, "/messages");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.confirmation) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "confirmation=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.content_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "contentType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.response_topic) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "responseTopic=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.timeout) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "timeout=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "topic=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.topic);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body = input.payload orelse "";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.correlation_data) |v| {
        try request.headers.put(allocator, "x-amz-mqtt5-correlation-data", v);
    }
    if (input.payload_format_indicator) |v| {
        try request.headers.put(allocator, "x-amz-mqtt5-payload-format-indicator", v.wireName());
    }
    if (input.user_properties) |v| {
        try request.headers.put(allocator, "x-amz-mqtt5-user-properties", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendDirectMessageOutput {
    const result: SendDirectMessageOutput = try aws.json.parseJsonObject(
        SendDirectMessageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
