const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OrganizationCustomPolicyRuleMetadata = @import("organization_custom_policy_rule_metadata.zig").OrganizationCustomPolicyRuleMetadata;
const OrganizationCustomRuleMetadata = @import("organization_custom_rule_metadata.zig").OrganizationCustomRuleMetadata;
const OrganizationManagedRuleMetadata = @import("organization_managed_rule_metadata.zig").OrganizationManagedRuleMetadata;

pub const PutOrganizationConfigRuleInput = struct {
    /// A comma-separated list of accounts that you want to exclude from an
    /// organization Config rule.
    excluded_accounts: ?[]const []const u8 = null,

    /// The name that you assign to an organization Config rule.
    organization_config_rule_name: []const u8,

    /// An `OrganizationCustomPolicyRuleMetadata` object. This object specifies
    /// metadata for your organization's Config Custom Policy rule. The metadata
    /// includes the runtime system in use, which accounts have debug
    /// logging enabled, and other custom rule metadata, such as resource type,
    /// resource ID of
    /// Amazon Web Services resource, and organization trigger types that initiate
    /// Config to evaluate Amazon Web Services resources against a rule.
    organization_custom_policy_rule_metadata: ?OrganizationCustomPolicyRuleMetadata = null,

    /// An `OrganizationCustomRuleMetadata` object. This object specifies
    /// organization custom rule metadata such as resource type,
    /// resource ID of Amazon Web Services resource, Lambda function ARN, and
    /// organization trigger types that trigger Config to evaluate your Amazon Web
    /// Services resources against a rule.
    /// It also provides the frequency with which you want Config to run evaluations
    /// for the rule if the trigger type is periodic.
    organization_custom_rule_metadata: ?OrganizationCustomRuleMetadata = null,

    /// An `OrganizationManagedRuleMetadata` object. This object specifies
    /// organization
    /// managed rule metadata such as resource type and ID of Amazon Web Services
    /// resource along with the rule identifier.
    /// It also provides the frequency with which you want Config to run evaluations
    /// for the rule if the trigger type is periodic.
    organization_managed_rule_metadata: ?OrganizationManagedRuleMetadata = null,

    pub const json_field_names = .{
        .excluded_accounts = "ExcludedAccounts",
        .organization_config_rule_name = "OrganizationConfigRuleName",
        .organization_custom_policy_rule_metadata = "OrganizationCustomPolicyRuleMetadata",
        .organization_custom_rule_metadata = "OrganizationCustomRuleMetadata",
        .organization_managed_rule_metadata = "OrganizationManagedRuleMetadata",
    };
};

pub const PutOrganizationConfigRuleOutput = struct {
    /// The Amazon Resource Name (ARN) of an organization Config rule.
    organization_config_rule_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .organization_config_rule_arn = "OrganizationConfigRuleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutOrganizationConfigRuleInput, options: CallOptions) !PutOrganizationConfigRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutOrganizationConfigRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.PutOrganizationConfigRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutOrganizationConfigRuleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutOrganizationConfigRuleOutput, body, allocator);
}
