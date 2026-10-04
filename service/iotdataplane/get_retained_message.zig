const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetRetainedMessageInput = struct {
    /// The topic name of the retained message to retrieve.
    topic: []const u8,

    pub const json_field_names = .{
        .topic = "topic",
    };
};

pub const GetRetainedMessageOutput = struct {
    /// The Epoch date and time, in milliseconds, when the retained message was
    /// stored by IoT.
    last_modified_time: ?i64 = null,

    /// The Base64-encoded message payload of the retained message body.
    payload: ?[]const u8 = null,

    /// The quality of service (QoS) level used to publish the retained message.
    qos: ?i32 = null,

    /// The topic name to which the retained message was published.
    topic: ?[]const u8 = null,

    /// A base64-encoded JSON string that includes an array of JSON objects, or null
    /// if the
    /// retained message doesn't include any user properties.
    ///
    /// The following example `userProperties` parameter is a JSON string that
    /// represents two user properties. Note that it will be base64-encoded:
    ///
    /// `[{"deviceName": "alpha"}, {"deviceCnt": "45"}]`
    user_properties: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_modified_time = "lastModifiedTime",
        .payload = "payload",
        .qos = "qos",
        .topic = "topic",
        .user_properties = "userProperties",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRetainedMessageInput, options: CallOptions) !GetRetainedMessageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRetainedMessageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data-ats.iot", "IoT Data Plane", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/retainedMessage/");
    try path_buf.appendSlice(allocator, input.topic);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRetainedMessageOutput {
    const result: GetRetainedMessageOutput = try aws.json.parseJsonObject(
        GetRetainedMessageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
