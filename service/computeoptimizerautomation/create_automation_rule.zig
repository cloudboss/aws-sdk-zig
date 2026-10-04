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

pub const CreateAutomationRuleInput = struct {
    /// A unique identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// A set of conditions that specify which recommended action qualify for
    /// implementation. When a rule is active and a recommended action matches these
    /// criteria, Compute Optimizer implements the action at the scheduled run time.
    criteria: ?Criteria = null,

    /// A description of the automation rule.
    description: ?[]const u8 = null,

    /// The name of the automation rule.
    name: []const u8,

    /// Configuration for organization-level rules. Required for OrganizationRule
    /// type.
    organization_configuration: ?OrganizationConfiguration = null,

    /// A string representation of a decimal number between 0 and 1 (having up to 30
    /// digits after the decimal point) that determines the priority of the rule.
    /// When multiple rules match the same recommended action, Compute Optimizer
    /// assigns the action to the rule with the lowest priority value (highest
    /// priority), even if that rule is scheduled to run later than other matching
    /// rules.
    priority: ?[]const u8 = null,

    /// The types of recommended actions this rule will automate.
    recommended_action_types: []const RecommendedActionType,

    /// The type of rule.
    ///
    /// Only the management account or a delegated administrator can set the
    /// ruleType to be OrganizationRule.
    rule_type: RuleType,

    /// The schedule for when the rule should run.
    schedule: Schedule,

    /// The status of the rule
    status: RuleStatus,

    /// The tags to associate with the rule.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .criteria = "criteria",
        .description = "description",
        .name = "name",
        .organization_configuration = "organizationConfiguration",
        .priority = "priority",
        .recommended_action_types = "recommendedActionTypes",
        .rule_type = "ruleType",
        .schedule = "schedule",
        .status = "status",
        .tags = "tags",
    };
};

pub const CreateAutomationRuleOutput = struct {
    /// The timestamp when the automation rule was created.
    created_timestamp: ?i64 = null,

    criteria: ?Criteria = null,

    /// A description of the automation rule. Can be up to 1024 characters long and
    /// contain alphanumeric characters, underscores, hyphens, spaces, and certain
    /// special characters.
    description: ?[]const u8 = null,

    /// The name of the automation rule. Must be 1-128 characters long and contain
    /// only alphanumeric characters, underscores, and hyphens.
    name: ?[]const u8 = null,

    /// Configuration settings for organization-wide rules, including rule
    /// application order and target account IDs.
    organization_configuration: ?OrganizationConfiguration = null,

    /// The priority level of the automation rule, used to determine execution order
    /// when multiple rules apply to the same resource.
    priority: ?[]const u8 = null,

    /// List of recommended action types that this rule can execute, such as
    /// SnapshotAndDeleteUnattachedEbsVolume or UpgradeEbsVolumeType.
    recommended_action_types: ?[]const RecommendedActionType = null,

    /// The Amazon Resource Name (ARN) of the created rule.
    rule_arn: ?[]const u8 = null,

    /// The unique identifier of the created rule.
    rule_id: ?[]const u8 = null,

    /// The revision number of the automation rule. This is incremented each time
    /// the rule is updated.
    rule_revision: ?i64 = null,

    /// The type of automation rule. Can be either OrganizationRule for
    /// organization-wide rules or AccountRule for account-specific rules.
    rule_type: ?RuleType = null,

    /// The schedule configuration for when the automation rule should execute,
    /// including cron expression, timezone, and execution window.
    schedule: ?Schedule = null,

    /// The current status of the automation rule. Can be Active or Inactive.
    status: ?RuleStatus = null,

    /// A list of key-value pairs used to categorize and organize the automation
    /// rule. Maximum of 200 tags allowed.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .created_timestamp = "createdTimestamp",
        .criteria = "criteria",
        .description = "description",
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAutomationRuleInput, options: CallOptions) !CreateAutomationRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAutomationRuleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerAutomationService.CreateAutomationRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAutomationRuleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAutomationRuleOutput, body, allocator);
}
