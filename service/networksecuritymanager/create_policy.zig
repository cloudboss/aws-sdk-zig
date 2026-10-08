const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TemplateOrRuleReference = @import("template_or_rule_reference.zig").TemplateOrRuleReference;
const PolicyFirewallType = @import("policy_firewall_type.zig").PolicyFirewallType;
const PolicyConfiguration = @import("policy_configuration.zig").PolicyConfiguration;
const AssociatedTemplateOrRule = @import("associated_template_or_rule.zig").AssociatedTemplateOrRule;
const EntityStatus = @import("entity_status.zig").EntityStatus;

pub const CreatePolicyInput = struct {
    /// The templates and rules to associate with the policy. For AWS WAF policies,
    /// specify 1 to 100 templates or rules, of which at most 2 can be templates.
    /// For AWS Shield Advanced policies, this list must be empty.
    associated_template_and_rule_list: ?[]const TemplateOrRuleReference = null,

    /// A unique, case-sensitive token that you provide to ensure that the operation
    /// completes no more than one time. If you retry a request with the same client
    /// token and the same parameters, the service returns the result of the
    /// original successful request.
    client_token: ?[]const u8 = null,

    /// The firewall type associated with the resource.
    firewall_type: PolicyFirewallType,

    /// Specifies whether to publish the resource. When `true`, the resource is
    /// saved in published (`ACTIVE`) state. When `false`, it is saved as a draft
    /// (`DRAFT`). Default: `true`.
    is_published: ?bool = null,

    /// The configuration settings that control the policy's behavior, including
    /// remediation and firewall-type-specific settings.
    policy_configuration: PolicyConfiguration,

    /// A description of the policy.
    policy_description: ?[]const u8 = null,

    /// The name of the policy.
    policy_name: []const u8,

    /// The priority of the resource. A lower number indicates a higher priority.
    priority: i32,

    /// The tags to add to the resource when it is created.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .associated_template_and_rule_list = "associatedTemplateAndRuleList",
        .client_token = "clientToken",
        .firewall_type = "firewallType",
        .is_published = "isPublished",
        .policy_configuration = "policyConfiguration",
        .policy_description = "policyDescription",
        .policy_name = "policyName",
        .priority = "priority",
        .tags = "tags",
    };
};

pub const CreatePolicyOutput = struct {
    /// The templates and rules associated with the policy. For AWS WAF policies,
    /// this list contains 1 to 100 templates or rules, of which at most 2 can be
    /// templates. For AWS Shield Advanced policies, this list is empty.
    associated_template_and_rule_list: ?[]const AssociatedTemplateOrRule = null,

    /// The firewall type associated with the resource.
    firewall_type: PolicyFirewallType,

    /// Specifies whether a published version of the resource exists.
    has_published_version: ?bool = null,

    /// Specifies whether the resource is a snapshot of a published version.
    is_snapshot: ?bool = null,

    /// The Amazon Resource Name (ARN) of the policy.
    policy_arn: []const u8,

    /// The configuration settings that control the policy's behavior, including
    /// remediation and firewall-type-specific settings.
    policy_configuration: ?PolicyConfiguration = null,

    /// A description of the policy.
    policy_description: ?[]const u8 = null,

    /// The service-generated id of the policy.
    policy_id: []const u8,

    /// The name of the policy.
    policy_name: []const u8,

    /// The priority of the resource. A lower number indicates a higher priority.
    priority: i32,

    /// The current status of the resource: `DRAFT` (unpublished, editable) or
    /// `ACTIVE` (published, in use).
    status: EntityStatus,

    /// The time when the resource was last updated.
    updated_at: ?i64 = null,

    /// A token used for optimistic concurrency control. Each read and write returns
    /// an `updateToken`. Provide the most recent value on your next update to
    /// detect and prevent conflicting concurrent modifications.
    update_token: ?[]const u8 = null,

    /// The version of the resource.
    version: []const u8,

    pub const json_field_names = .{
        .associated_template_and_rule_list = "associatedTemplateAndRuleList",
        .firewall_type = "firewallType",
        .has_published_version = "hasPublishedVersion",
        .is_snapshot = "isSnapshot",
        .policy_arn = "policyArn",
        .policy_configuration = "policyConfiguration",
        .policy_description = "policyDescription",
        .policy_id = "policyId",
        .policy_name = "policyName",
        .priority = "priority",
        .status = "status",
        .updated_at = "updatedAt",
        .update_token = "updateToken",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePolicyInput, options: CallOptions) !CreatePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "network-security-manager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-security-manager", "Network Security Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/policies";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.associated_template_and_rule_list) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"associatedTemplateAndRuleList\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"firewallType\":");
    try aws.json.writeValue(@TypeOf(input.firewall_type), input.firewall_type, allocator, &body_buf);
    has_prev = true;
    if (input.is_published) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"isPublished\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.policy_configuration), input.policy_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.policy_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"policyDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyName\":");
    try aws.json.writeValue(@TypeOf(input.policy_name), input.policy_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"priority\":");
    try aws.json.writeValue(@TypeOf(input.priority), input.priority, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePolicyOutput {
    const result: CreatePolicyOutput = try aws.json.parseJsonObject(
        CreatePolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
