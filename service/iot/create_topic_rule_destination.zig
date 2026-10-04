const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TopicRuleDestinationConfiguration = @import("topic_rule_destination_configuration.zig").TopicRuleDestinationConfiguration;
const TopicRuleDestination = @import("topic_rule_destination.zig").TopicRuleDestination;

pub const CreateTopicRuleDestinationInput = struct {
    /// The topic rule destination configuration.
    destination_configuration: TopicRuleDestinationConfiguration,

    pub const json_field_names = .{
        .destination_configuration = "destinationConfiguration",
    };
};

pub const CreateTopicRuleDestinationOutput = struct {
    /// The topic rule destination.
    topic_rule_destination: ?TopicRuleDestination = null,

    pub const json_field_names = .{
        .topic_rule_destination = "topicRuleDestination",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTopicRuleDestinationInput, options: CallOptions) !CreateTopicRuleDestinationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTopicRuleDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/destinations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destinationConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.destination_configuration), input.destination_configuration, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTopicRuleDestinationOutput {
    const result: CreateTopicRuleDestinationOutput = try aws.json.parseJsonObject(
        CreateTopicRuleDestinationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
