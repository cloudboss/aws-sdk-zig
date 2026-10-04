const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImpersonationRule = @import("impersonation_rule.zig").ImpersonationRule;
const ImpersonationRoleType = @import("impersonation_role_type.zig").ImpersonationRoleType;

pub const GetImpersonationRoleInput = struct {
    /// The impersonation role ID to retrieve.
    impersonation_role_id: []const u8,

    /// The WorkMail organization from which to retrieve the impersonation role.
    organization_id: []const u8,

    pub const json_field_names = .{
        .impersonation_role_id = "ImpersonationRoleId",
        .organization_id = "OrganizationId",
    };
};

pub const GetImpersonationRoleOutput = struct {
    /// The date when the impersonation role was created.
    date_created: ?i64 = null,

    /// The date when the impersonation role was last modified.
    date_modified: ?i64 = null,

    /// The impersonation role description.
    description: ?[]const u8 = null,

    /// The impersonation role ID.
    impersonation_role_id: ?[]const u8 = null,

    /// The impersonation role name.
    name: ?[]const u8 = null,

    /// The list of rules for the given impersonation role.
    rules: ?[]const ImpersonationRule = null,

    /// The impersonation role type.
    @"type": ?ImpersonationRoleType = null,

    pub const json_field_names = .{
        .date_created = "DateCreated",
        .date_modified = "DateModified",
        .description = "Description",
        .impersonation_role_id = "ImpersonationRoleId",
        .name = "Name",
        .rules = "Rules",
        .@"type" = "Type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetImpersonationRoleInput, options: CallOptions) !GetImpersonationRoleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetImpersonationRoleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.GetImpersonationRole");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetImpersonationRoleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetImpersonationRoleOutput, body, allocator);
}
