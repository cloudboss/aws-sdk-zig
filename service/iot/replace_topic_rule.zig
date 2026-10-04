const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TopicRulePayload = @import("topic_rule_payload.zig").TopicRulePayload;

pub const ReplaceTopicRuleInput = struct {
    /// The name of the rule.
    rule_name: []const u8,

    /// The rule payload.
    topic_rule_payload: TopicRulePayload,

    pub const json_field_names = .{
        .rule_name = "ruleName",
        .topic_rule_payload = "topicRulePayload",
    };
};

pub const ReplaceTopicRuleOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ReplaceTopicRuleInput, options: CallOptions) !ReplaceTopicRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ReplaceTopicRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/rules/");
    try path_buf.appendSlice(allocator, input.rule_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body = try aws.json.jsonStringify(input.topic_rule_payload, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ReplaceTopicRuleOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: ReplaceTopicRuleOutput = .{};

    return result;
}
