const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CentralizationRule = @import("centralization_rule.zig").CentralizationRule;
const ContextGraphStatus = @import("context_graph_status.zig").ContextGraphStatus;
const CentralizationFailureReason = @import("centralization_failure_reason.zig").CentralizationFailureReason;
const RuleHealth = @import("rule_health.zig").RuleHealth;
const TagPropagationFailureReason = @import("tag_propagation_failure_reason.zig").TagPropagationFailureReason;
const TagPropagationStatus = @import("tag_propagation_status.zig").TagPropagationStatus;

pub const GetCentralizationRuleForOrganizationInput = struct {
    /// The identifier (name or ARN) of the organization centralization rule to
    /// retrieve.
    rule_identifier: []const u8,

    pub const json_field_names = .{
        .rule_identifier = "RuleIdentifier",
    };
};

pub const GetCentralizationRuleForOrganizationOutput = struct {
    /// The configuration details for the organization centralization rule.
    centralization_rule: ?CentralizationRule = null,

    /// The status of context graph centralization for this rule. Returns
    /// `Provisioning` while the context graph is being set up, `Healthy` once it is
    /// active, or `Unhealthy` if provisioning failed. This status is independent of
    /// the overall `RuleHealth` for log delivery.
    context_graph_status: ?ContextGraphStatus = null,

    /// The Amazon Web Services region where the organization centralization rule
    /// was created.
    created_region: ?[]const u8 = null,

    /// The timestamp when the organization centralization rule was created.
    created_time_stamp: ?i64 = null,

    /// The Amazon Web Services Account that created the organization centralization
    /// rule.
    creator_account_id: ?[]const u8 = null,

    /// The reason why an organization centralization rule is marked UNHEALTHY.
    failure_reason: ?CentralizationFailureReason = null,

    /// The timestamp when the organization centralization rule was last updated.
    last_update_time_stamp: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the organization centralization rule.
    rule_arn: ?[]const u8 = null,

    /// The health status of the organization centralization rule.
    rule_health: ?RuleHealth = null,

    /// The name of the organization centralization rule.
    rule_name: ?[]const u8 = null,

    /// The reason tag propagation is unhealthy for this rule. Only present when
    /// `TagPropagationStatus` is `Unhealthy`.
    tag_propagation_failure_reason: ?TagPropagationFailureReason = null,

    /// The health status of tag propagation for this rule. This status is
    /// independent of the overall `RuleHealth` for log delivery. Returns `Healthy`
    /// when the most recent tag-propagation attempt succeeded, or `Unhealthy` when
    /// the most recent attempt failed.
    tag_propagation_status: ?TagPropagationStatus = null,

    pub const json_field_names = .{
        .centralization_rule = "CentralizationRule",
        .context_graph_status = "ContextGraphStatus",
        .created_region = "CreatedRegion",
        .created_time_stamp = "CreatedTimeStamp",
        .creator_account_id = "CreatorAccountId",
        .failure_reason = "FailureReason",
        .last_update_time_stamp = "LastUpdateTimeStamp",
        .rule_arn = "RuleArn",
        .rule_health = "RuleHealth",
        .rule_name = "RuleName",
        .tag_propagation_failure_reason = "TagPropagationFailureReason",
        .tag_propagation_status = "TagPropagationStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCentralizationRuleForOrganizationInput, options: CallOptions) !GetCentralizationRuleForOrganizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "observabilityadmin", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCentralizationRuleForOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("observabilityadmin", "ObservabilityAdmin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetCentralizationRuleForOrganization";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RuleIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.rule_identifier), input.rule_identifier, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCentralizationRuleForOrganizationOutput {
    const result: GetCentralizationRuleForOrganizationOutput = try aws.json.parseJsonObject(
        GetCentralizationRuleForOrganizationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
