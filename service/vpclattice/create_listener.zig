const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleAction = @import("rule_action.zig").RuleAction;
const ListenerProtocol = @import("listener_protocol.zig").ListenerProtocol;

pub const CreateListenerInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you retry a request that completed
    /// successfully using the same client token and parameters, the retry succeeds
    /// without performing any actions. If the parameters aren't identical, the
    /// retry fails.
    client_token: ?[]const u8 = null,

    /// The action for the default rule. Each listener has a default rule. The
    /// default rule is used if no other rules match.
    default_action: RuleAction,

    /// The name of the listener. A listener name must be unique within a service.
    /// The valid characters are a-z, 0-9, and hyphens (-). You can't use a hyphen
    /// as the first or last character, or immediately after another hyphen.
    name: []const u8,

    /// The listener port. You can specify a value from 1 to 65535. For HTTP, the
    /// default is 80. For HTTPS, the default is 443.
    port: ?i32 = null,

    /// The listener protocol.
    protocol: ListenerProtocol,

    /// The ID or ARN of the service.
    service_identifier: []const u8,

    /// The tags for the listener.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .default_action = "defaultAction",
        .name = "name",
        .port = "port",
        .protocol = "protocol",
        .service_identifier = "serviceIdentifier",
        .tags = "tags",
    };
};

pub const CreateListenerOutput = struct {
    /// The Amazon Resource Name (ARN) of the listener.
    arn: ?[]const u8 = null,

    /// The action for the default rule.
    default_action: ?RuleAction = null,

    /// The ID of the listener.
    id: ?[]const u8 = null,

    /// The name of the listener.
    name: ?[]const u8 = null,

    /// The port number of the listener.
    port: ?i32 = null,

    /// The protocol of the listener.
    protocol: ?ListenerProtocol = null,

    /// The Amazon Resource Name (ARN) of the service.
    service_arn: ?[]const u8 = null,

    /// The ID of the service.
    service_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .default_action = "defaultAction",
        .id = "id",
        .name = "name",
        .port = "port",
        .protocol = "protocol",
        .service_arn = "serviceArn",
        .service_id = "serviceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateListenerInput, options: CallOptions) !CreateListenerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "vpc-lattice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateListenerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/services/");
    try path_buf.appendSlice(allocator, input.service_identifier);
    try path_buf.appendSlice(allocator, "/listeners");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"defaultAction\":");
    try aws.json.writeValue(@TypeOf(input.default_action), input.default_action, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.port) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"port\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"protocol\":");
    try aws.json.writeValue(@TypeOf(input.protocol), input.protocol, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateListenerOutput {
    var result: CreateListenerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateListenerOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
