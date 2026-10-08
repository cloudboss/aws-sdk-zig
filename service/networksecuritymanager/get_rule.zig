const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleFirewallType = @import("rule_firewall_type.zig").RuleFirewallType;
const RuleType = @import("rule_type.zig").RuleType;
const EntityStatus = @import("entity_status.zig").EntityStatus;

pub const GetRuleInput = struct {
    /// The identifier of the rule. This is the rule's Amazon Resource Name (ARN).
    rule_identifier: []const u8,

    pub const json_field_names = .{
        .rule_identifier = "ruleIdentifier",
    };
};

pub const GetRuleOutput = struct {
    /// The firewall configuration for the rule, as a JSON document. The structure
    /// depends on the rule's firewall type and rule type.
    configuration: []const u8,

    /// The firewall type associated with the resource.
    firewall_type: RuleFirewallType,

    /// Specifies whether a published version of the resource exists.
    has_published_version: ?bool = null,

    /// Specifies whether the resource is a snapshot of a published version.
    is_snapshot: ?bool = null,

    /// The Amazon Resource Name (ARN) of the rule.
    rule_arn: []const u8,

    /// A description of the rule.
    rule_description: ?[]const u8 = null,

    /// The service-generated id of the rule.
    rule_id: []const u8,

    /// The name of the rule.
    rule_name: []const u8,

    /// The type of the rule. `CONFIGURATION` rules contain firewall settings, and
    /// `INSPECTION` rules contain rule groups.
    rule_type: ?RuleType = null,

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
        .configuration = "configuration",
        .firewall_type = "firewallType",
        .has_published_version = "hasPublishedVersion",
        .is_snapshot = "isSnapshot",
        .rule_arn = "ruleArn",
        .rule_description = "ruleDescription",
        .rule_id = "ruleId",
        .rule_name = "ruleName",
        .rule_type = "ruleType",
        .status = "status",
        .updated_at = "updatedAt",
        .update_token = "updateToken",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRuleInput, options: CallOptions) !GetRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-security-manager", "Network Security Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/rules/");
    try path_buf.appendSlice(allocator, input.rule_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRuleOutput {
    const result: GetRuleOutput = try aws.json.parseJsonObject(
        GetRuleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
