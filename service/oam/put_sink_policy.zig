const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutSinkPolicyInput = struct {
    /// The JSON policy to use. If you are updating an existing policy, the entire
    /// existing policy is replaced by what you specify here.
    ///
    /// The policy must be in JSON string format with quotation marks escaped and no
    /// newlines.
    ///
    /// For examples of different types of policies, see the **Examples** section on
    /// this page.
    policy: []const u8,

    /// The ARN of the sink to attach this policy to.
    sink_identifier: []const u8,

    pub const json_field_names = .{
        .policy = "Policy",
        .sink_identifier = "SinkIdentifier",
    };
};

pub const PutSinkPolicyOutput = struct {
    /// The policy that you specified.
    policy: ?[]const u8 = null,

    /// The ARN of the sink.
    sink_arn: ?[]const u8 = null,

    /// The random ID string that Amazon Web Services generated as part of the sink
    /// ARN.
    sink_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy = "Policy",
        .sink_arn = "SinkArn",
        .sink_id = "SinkId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutSinkPolicyInput, options: CallOptions) !PutSinkPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "oam", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutSinkPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("oam", "OAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/PutSinkPolicy";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Policy\":");
    try aws.json.writeValue(@TypeOf(input.policy), input.policy, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SinkIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.sink_identifier), input.sink_identifier, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutSinkPolicyOutput {
    var result: PutSinkPolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutSinkPolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
