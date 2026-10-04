const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TopicRuleDestinationStatus = @import("topic_rule_destination_status.zig").TopicRuleDestinationStatus;

pub const UpdateTopicRuleDestinationInput = struct {
    /// The ARN of the topic rule destination.
    arn: []const u8,

    /// The status of the topic rule destination. Valid values are:
    ///
    /// **IN_PROGRESS**
    ///
    /// A topic rule destination was created but has not been confirmed. You can set
    /// `status` to `IN_PROGRESS` by calling
    /// `UpdateTopicRuleDestination`. Calling
    /// `UpdateTopicRuleDestination` causes a new confirmation challenge to
    /// be sent to your confirmation endpoint.
    ///
    /// **ENABLED**
    ///
    /// Confirmation was completed, and traffic to this destination is allowed. You
    /// can
    /// set `status` to `DISABLED` by calling
    /// `UpdateTopicRuleDestination`.
    ///
    /// **DISABLED**
    ///
    /// Confirmation was completed, and traffic to this destination is not allowed.
    /// You
    /// can set `status` to `ENABLED` by calling
    /// `UpdateTopicRuleDestination`.
    ///
    /// **ERROR**
    ///
    /// Confirmation could not be completed, for example if the confirmation timed
    /// out.
    /// You can call `GetTopicRuleDestination` for details about the error. You
    /// can set `status` to `IN_PROGRESS` by calling
    /// `UpdateTopicRuleDestination`. Calling
    /// `UpdateTopicRuleDestination` causes a new confirmation challenge to
    /// be sent to your confirmation endpoint.
    status: TopicRuleDestinationStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .status = "status",
    };
};

pub const UpdateTopicRuleDestinationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTopicRuleDestinationInput, options: CallOptions) !UpdateTopicRuleDestinationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTopicRuleDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/destinations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"status\":");
    try aws.json.writeValue(@TypeOf(input.status), input.status, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTopicRuleDestinationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateTopicRuleDestinationOutput = .{};

    return result;
}
