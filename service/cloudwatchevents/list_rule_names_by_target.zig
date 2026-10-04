const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListRuleNamesByTargetInput = struct {
    /// The name or ARN of the event bus to list rules for. If you omit this, the
    /// default event
    /// bus is used.
    event_bus_name: ?[]const u8 = null,

    /// The maximum number of results to return.
    limit: ?i32 = null,

    /// The token returned by a previous call to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the target resource.
    target_arn: []const u8,

    pub const json_field_names = .{
        .event_bus_name = "EventBusName",
        .limit = "Limit",
        .next_token = "NextToken",
        .target_arn = "TargetArn",
    };
};

pub const ListRuleNamesByTargetOutput = struct {
    /// Indicates whether there are additional results to retrieve. If there are no
    /// more results,
    /// the value is null.
    next_token: ?[]const u8 = null,

    /// The names of the rules that can invoke the given target.
    rule_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .rule_names = "RuleNames",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRuleNamesByTargetInput, options: CallOptions) !ListRuleNamesByTargetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "events", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRuleNamesByTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("events", "CloudWatch Events", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.ListRuleNamesByTarget");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRuleNamesByTargetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListRuleNamesByTargetOutput, body, allocator);
}
