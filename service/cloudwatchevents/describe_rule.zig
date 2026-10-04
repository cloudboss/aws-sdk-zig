const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleState = @import("rule_state.zig").RuleState;

pub const DescribeRuleInput = struct {
    /// The name or ARN of the event bus associated with the rule. If you omit this,
    /// the default
    /// event bus is used.
    event_bus_name: ?[]const u8 = null,

    /// The name of the rule.
    name: []const u8,

    pub const json_field_names = .{
        .event_bus_name = "EventBusName",
        .name = "Name",
    };
};

pub const DescribeRuleOutput = struct {
    /// The Amazon Resource Name (ARN) of the rule.
    arn: ?[]const u8 = null,

    /// The account ID of the user that created the rule. If you use `PutRule` to
    /// put a
    /// rule on an event bus in another account, the other account is the owner of
    /// the rule, and the
    /// rule ARN includes the account ID for that account. However, the value for
    /// `CreatedBy` is the account ID as the account that created the rule in the
    /// other
    /// account.
    created_by: ?[]const u8 = null,

    /// The description of the rule.
    description: ?[]const u8 = null,

    /// The name of the event bus associated with the rule.
    event_bus_name: ?[]const u8 = null,

    /// The event pattern. For more information, see [Events and Event
    /// Patterns](https://docs.aws.amazon.com/eventbridge/latest/userguide/eventbridge-and-event-patterns.html) in the *Amazon EventBridge User Guide*.
    event_pattern: ?[]const u8 = null,

    /// If this is a managed rule, created by an Amazon Web Services service on your
    /// behalf, this field displays
    /// the principal name of the Amazon Web Services service that created the rule.
    managed_by: ?[]const u8 = null,

    /// The name of the rule.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role associated with the rule.
    role_arn: ?[]const u8 = null,

    /// The scheduling expression. For example, "cron(0 20 * * ? *)", "rate(5
    /// minutes)".
    schedule_expression: ?[]const u8 = null,

    /// Specifies whether the rule is enabled or disabled.
    state: ?RuleState = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_by = "CreatedBy",
        .description = "Description",
        .event_bus_name = "EventBusName",
        .event_pattern = "EventPattern",
        .managed_by = "ManagedBy",
        .name = "Name",
        .role_arn = "RoleArn",
        .schedule_expression = "ScheduleExpression",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRuleInput, options: CallOptions) !DescribeRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRuleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.DescribeRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRuleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeRuleOutput, body, allocator);
}
