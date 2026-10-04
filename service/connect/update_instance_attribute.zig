const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceAttributeType = @import("instance_attribute_type.zig").InstanceAttributeType;

pub const UpdateInstanceAttributeInput = struct {
    /// The type of attribute.
    ///
    /// Only allowlisted customers can consume USE_CUSTOM_TTS_VOICES. To access this
    /// feature, contact Amazon Web Services Support for allowlisting.
    ///
    /// If you set the attribute type as `MESSAGE_STREAMING`, you need to update the
    /// Lex bot alias resource
    /// based policy to include the `lex:RecognizeMessageAsync` action for the
    /// connect instance ARN
    /// resource.
    ///
    /// If you set the attribute type `AUTO_MUTE_AGENT_ON_HOLD` to `true`, the
    /// system
    /// automatically mutes agents while they're on hold and unmutes them when they
    /// resume the contact. Agents can't
    /// change their mute state while on hold.
    attribute_type: InstanceAttributeType,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The value for the attribute. Maximum character limit is 100.
    value: []const u8,

    pub const json_field_names = .{
        .attribute_type = "AttributeType",
        .client_token = "ClientToken",
        .instance_id = "InstanceId",
        .value = "Value",
    };
};

pub const UpdateInstanceAttributeOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateInstanceAttributeInput, options: CallOptions) !UpdateInstanceAttributeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateInstanceAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/instance/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/attribute/");
    try path_buf.appendSlice(allocator, input.attribute_type);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Value\":");
    try aws.json.writeValue(@TypeOf(input.value), input.value, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateInstanceAttributeOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateInstanceAttributeOutput = .{};

    return result;
}
