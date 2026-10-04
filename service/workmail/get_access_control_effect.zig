const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessControlRuleEffect = @import("access_control_rule_effect.zig").AccessControlRuleEffect;

pub const GetAccessControlEffectInput = struct {
    /// The access protocol action. Valid values include `ActiveSync`,
    /// `AutoDiscover`, `EWS`, `IMAP`, `SMTP`,
    /// `WindowsOutlook`, and `WebMail`.
    action: []const u8,

    /// The impersonation role ID.
    impersonation_role_id: ?[]const u8 = null,

    /// The IPv4 address.
    ip_address: []const u8,

    /// The identifier for the organization.
    organization_id: []const u8,

    /// The user ID.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "Action",
        .impersonation_role_id = "ImpersonationRoleId",
        .ip_address = "IpAddress",
        .organization_id = "OrganizationId",
        .user_id = "UserId",
    };
};

pub const GetAccessControlEffectOutput = struct {
    /// The rule effect.
    effect: ?AccessControlRuleEffect = null,

    /// The rules that match the given parameters, resulting in an effect.
    matched_rules: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .effect = "Effect",
        .matched_rules = "MatchedRules",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccessControlEffectInput, options: CallOptions) !GetAccessControlEffectOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccessControlEffectInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.GetAccessControlEffect");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccessControlEffectOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetAccessControlEffectOutput, body, allocator);
}
