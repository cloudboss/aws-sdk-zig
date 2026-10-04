const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Criteria = @import("criteria.zig").Criteria;
const OrganizationConfiguration = @import("organization_configuration.zig").OrganizationConfiguration;
const RecommendedActionType = @import("recommended_action_type.zig").RecommendedActionType;
const RuleType = @import("rule_type.zig").RuleType;
const Schedule = @import("schedule.zig").Schedule;
const RuleStatus = @import("rule_status.zig").RuleStatus;
const Tag = @import("tag.zig").Tag;

pub const GetAutomationRuleInput = struct {
    /// The ARN of the rule to retrieve.
    rule_arn: []const u8,

    pub const json_field_names = .{
        .rule_arn = "ruleArn",
    };
};

pub const GetAutomationRuleOutput = struct {
    /// The 12-digit Amazon Web Services account ID that owns this automation rule.
    account_id: ?[]const u8 = null,

    /// The timestamp when the automation rule was created.
    created_timestamp: ?i64 = null,

    criteria: ?Criteria = null,

    /// A description of the automation rule.
    description: ?[]const u8 = null,

    /// The timestamp when the automation rule was last updated.
    last_updated_timestamp: ?i64 = null,

    /// The name of the automation rule.
    name: ?[]const u8 = null,

    organization_configuration: ?OrganizationConfiguration = null,

    /// A string representation of a decimal number between 0 and 1 (having up to 30
    /// digits after the decimal point) that determines the priority of the rule.
    priority: ?[]const u8 = null,

    /// List of recommended action types that this rule can execute.
    recommended_action_types: ?[]const RecommendedActionType = null,

    /// The Amazon Resource Name (ARN) of the automation rule.
    rule_arn: ?[]const u8 = null,

    /// The unique identifier of the automation rule.
    rule_id: ?[]const u8 = null,

    /// The revision number of the automation rule.
    rule_revision: ?i64 = null,

    /// The type of automation rule.
    rule_type: ?RuleType = null,

    schedule: ?Schedule = null,

    /// The current status of the automation rule (Active or Inactive).
    status: ?RuleStatus = null,

    /// The tags associated with the automation rule.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .created_timestamp = "createdTimestamp",
        .criteria = "criteria",
        .description = "description",
        .last_updated_timestamp = "lastUpdatedTimestamp",
        .name = "name",
        .organization_configuration = "organizationConfiguration",
        .priority = "priority",
        .recommended_action_types = "recommendedActionTypes",
        .rule_arn = "ruleArn",
        .rule_id = "ruleId",
        .rule_revision = "ruleRevision",
        .rule_type = "ruleType",
        .schedule = "schedule",
        .status = "status",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAutomationRuleInput, options: CallOptions) !GetAutomationRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "compute-optimizer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAutomationRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aco-automation", "Compute Optimizer Automation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerAutomationService.GetAutomationRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAutomationRuleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetAutomationRuleOutput, body, allocator);
}
