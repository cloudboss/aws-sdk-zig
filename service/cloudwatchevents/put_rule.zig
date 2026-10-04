const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleState = @import("rule_state.zig").RuleState;
const Tag = @import("tag.zig").Tag;

pub const PutRuleInput = struct {
    /// A description of the rule.
    description: ?[]const u8 = null,

    /// The name or ARN of the event bus to associate with this rule. If you omit
    /// this, the
    /// default event bus is used.
    event_bus_name: ?[]const u8 = null,

    /// The event pattern. For more information, see [Events and Event
    /// Patterns](https://docs.aws.amazon.com/eventbridge/latest/userguide/eventbridge-and-event-patterns.html) in the *Amazon EventBridge User Guide*.
    event_pattern: ?[]const u8 = null,

    /// The name of the rule that you are creating or updating.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role associated with the rule.
    ///
    /// If you're setting an event bus in another account as the target and that
    /// account granted
    /// permission to your account through an organization instead of directly by
    /// the account ID, you
    /// must specify a `RoleArn` with proper permissions in the `Target`
    /// structure, instead of here in this parameter.
    role_arn: ?[]const u8 = null,

    /// The scheduling expression. For example, "cron(0 20 * * ? *)" or "rate(5
    /// minutes)".
    schedule_expression: ?[]const u8 = null,

    /// Indicates whether the rule is enabled or disabled.
    state: ?RuleState = null,

    /// The list of key-value pairs to associate with the rule.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "Description",
        .event_bus_name = "EventBusName",
        .event_pattern = "EventPattern",
        .name = "Name",
        .role_arn = "RoleArn",
        .schedule_expression = "ScheduleExpression",
        .state = "State",
        .tags = "Tags",
    };
};

pub const PutRuleOutput = struct {
    /// The Amazon Resource Name (ARN) of the rule.
    rule_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .rule_arn = "RuleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRuleInput, options: CallOptions) !PutRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRuleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.PutRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRuleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutRuleOutput, body, allocator);
}
