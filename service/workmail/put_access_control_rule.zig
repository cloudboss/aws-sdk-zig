const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessControlRuleEffect = @import("access_control_rule_effect.zig").AccessControlRuleEffect;

pub const PutAccessControlRuleInput = struct {
    /// Access protocol actions to include in the rule. Valid values include
    /// `ActiveSync`, `AutoDiscover`, `EWS`, `IMAP`,
    /// `SMTP`, `WindowsOutlook`, and `WebMail`.
    actions: ?[]const []const u8 = null,

    /// The rule description.
    description: []const u8,

    /// The rule effect.
    effect: AccessControlRuleEffect,

    /// Impersonation role IDs to include in the rule.
    impersonation_role_ids: ?[]const []const u8 = null,

    /// IPv4 CIDR ranges to include in the rule.
    ip_ranges: ?[]const []const u8 = null,

    /// The rule name.
    name: []const u8,

    /// Access protocol actions to exclude from the rule. Valid values include
    /// `ActiveSync`, `AutoDiscover`, `EWS`, `IMAP`,
    /// `SMTP`, `WindowsOutlook`, and `WebMail`.
    not_actions: ?[]const []const u8 = null,

    /// Impersonation role IDs to exclude from the rule.
    not_impersonation_role_ids: ?[]const []const u8 = null,

    /// IPv4 CIDR ranges to exclude from the rule.
    not_ip_ranges: ?[]const []const u8 = null,

    /// User IDs to exclude from the rule.
    not_user_ids: ?[]const []const u8 = null,

    /// The identifier of the organization.
    organization_id: []const u8,

    /// User IDs to include in the rule.
    user_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .description = "Description",
        .effect = "Effect",
        .impersonation_role_ids = "ImpersonationRoleIds",
        .ip_ranges = "IpRanges",
        .name = "Name",
        .not_actions = "NotActions",
        .not_impersonation_role_ids = "NotImpersonationRoleIds",
        .not_ip_ranges = "NotIpRanges",
        .not_user_ids = "NotUserIds",
        .organization_id = "OrganizationId",
        .user_ids = "UserIds",
    };
};

pub const PutAccessControlRuleOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAccessControlRuleInput, options: CallOptions) !PutAccessControlRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workmail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAccessControlRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workmail", "WorkMail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.PutAccessControlRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAccessControlRuleOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
