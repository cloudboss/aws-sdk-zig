const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImpersonationRule = @import("impersonation_rule.zig").ImpersonationRule;
const ImpersonationRoleType = @import("impersonation_role_type.zig").ImpersonationRoleType;

pub const UpdateImpersonationRoleInput = struct {
    /// The updated impersonation role description.
    description: ?[]const u8 = null,

    /// The ID of the impersonation role to update.
    impersonation_role_id: []const u8,

    /// The updated impersonation role name.
    name: []const u8,

    /// The WorkMail organization that contains the impersonation role to update.
    organization_id: []const u8,

    /// The updated list of rules.
    rules: []const ImpersonationRule,

    /// The updated impersonation role type.
    type: ImpersonationRoleType,

    pub const json_field_names = .{
        .description = "Description",
        .impersonation_role_id = "ImpersonationRoleId",
        .name = "Name",
        .organization_id = "OrganizationId",
        .rules = "Rules",
        .type = "Type",
    };
};

pub const UpdateImpersonationRoleOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateImpersonationRoleInput, options: CallOptions) !UpdateImpersonationRoleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateImpersonationRoleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.UpdateImpersonationRole");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateImpersonationRoleOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
