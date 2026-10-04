const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssumeImpersonationRoleInput = struct {
    /// The impersonation role ID to assume.
    impersonation_role_id: []const u8,

    /// The WorkMail organization under which the impersonation role will be
    /// assumed.
    organization_id: []const u8,

    pub const json_field_names = .{
        .impersonation_role_id = "ImpersonationRoleId",
        .organization_id = "OrganizationId",
    };
};

pub const AssumeImpersonationRoleOutput = struct {
    /// The authentication token's validity, in seconds.
    expires_in: ?i64 = null,

    /// The authentication token for the impersonation role.
    token: ?[]const u8 = null,

    pub const json_field_names = .{
        .expires_in = "ExpiresIn",
        .token = "Token",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssumeImpersonationRoleInput, options: CallOptions) !AssumeImpersonationRoleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssumeImpersonationRoleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.AssumeImpersonationRole");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssumeImpersonationRoleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AssumeImpersonationRoleOutput, body, allocator);
}
