const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessEffect = @import("access_effect.zig").AccessEffect;
const ImpersonationMatchedRule = @import("impersonation_matched_rule.zig").ImpersonationMatchedRule;
const ImpersonationRoleType = @import("impersonation_role_type.zig").ImpersonationRoleType;

pub const GetImpersonationRoleEffectInput = struct {
    /// The impersonation role ID to test.
    impersonation_role_id: []const u8,

    /// The WorkMail organization where the impersonation role is defined.
    organization_id: []const u8,

    /// The WorkMail organization user chosen to test the impersonation role. The
    /// following identity
    /// formats are available:
    ///
    /// * User ID: `12345678-1234-1234-1234-123456789012` or
    ///   `S-1-1-12-1234567890-123456789-123456789-1234`
    ///
    /// * Email address: `user@domain.tld`
    ///
    /// * User name: `user`
    target_user: []const u8,

    pub const json_field_names = .{
        .impersonation_role_id = "ImpersonationRoleId",
        .organization_id = "OrganizationId",
        .target_user = "TargetUser",
    };
};

pub const GetImpersonationRoleEffectOutput = struct {
    /// ``Effect of the impersonation role on the target user based on its rules.
    /// Available
    /// effects are `ALLOW` or `DENY`.
    effect: ?AccessEffect = null,

    /// A list of the rules that match the input and produce the configured effect.
    matched_rules: ?[]const ImpersonationMatchedRule = null,

    /// The impersonation role type.
    @"type": ?ImpersonationRoleType = null,

    pub const json_field_names = .{
        .effect = "Effect",
        .matched_rules = "MatchedRules",
        .@"type" = "Type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetImpersonationRoleEffectInput, options: CallOptions) !GetImpersonationRoleEffectOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetImpersonationRoleEffectInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.GetImpersonationRoleEffect");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetImpersonationRoleEffectOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetImpersonationRoleEffectOutput, body, allocator);
}
