const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImpersonationRule = @import("impersonation_rule.zig").ImpersonationRule;
const ImpersonationRoleType = @import("impersonation_role_type.zig").ImpersonationRoleType;

pub const CreateImpersonationRoleInput = struct {
    /// The idempotency token for the client request.
    client_token: ?[]const u8 = null,

    /// The description of the new impersonation role.
    description: ?[]const u8 = null,

    /// The name of the new impersonation role.
    name: []const u8,

    /// The WorkMail organization to create the new impersonation role within.
    organization_id: []const u8,

    /// The list of rules for the impersonation role.
    rules: []const ImpersonationRule,

    /// The impersonation role's type. The available impersonation role types are
    /// `READ_ONLY` or `FULL_ACCESS`.
    type: ImpersonationRoleType,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .name = "Name",
        .organization_id = "OrganizationId",
        .rules = "Rules",
        .type = "Type",
    };
};

pub const CreateImpersonationRoleOutput = struct {
    /// The new impersonation role ID.
    impersonation_role_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .impersonation_role_id = "ImpersonationRoleId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateImpersonationRoleInput, options: CallOptions) !CreateImpersonationRoleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateImpersonationRoleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.CreateImpersonationRole");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateImpersonationRoleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateImpersonationRoleOutput, body, allocator);
}
