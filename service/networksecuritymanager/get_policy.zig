const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssociatedTemplateOrRule = @import("associated_template_or_rule.zig").AssociatedTemplateOrRule;
const PolicyFirewallType = @import("policy_firewall_type.zig").PolicyFirewallType;
const PolicyConfiguration = @import("policy_configuration.zig").PolicyConfiguration;
const EntityStatus = @import("entity_status.zig").EntityStatus;

pub const GetPolicyInput = struct {
    /// The identifier of the policy. This is the policy's Amazon Resource Name
    /// (ARN).
    policy_identifier: []const u8,

    pub const json_field_names = .{
        .policy_identifier = "policyIdentifier",
    };
};

pub const GetPolicyOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPolicyInput, options: CallOptions) !GetPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-security-manager", "Network Security Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/policies/");
    try path_buf.appendSlice(allocator, input.policy_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPolicyOutput {
    const result: GetPolicyOutput = try aws.json.parseJsonObject(
        GetPolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
