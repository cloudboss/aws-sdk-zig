const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImpersonationRole = @import("impersonation_role.zig").ImpersonationRole;

pub const ListImpersonationRolesInput = struct {
    /// The maximum number of results returned in a single call.
    max_results: ?i32 = null,

    /// The token used to retrieve the next page of results. The first call doesn't
    /// require a
    /// token.
    next_token: ?[]const u8 = null,

    /// The WorkMail organization to which the listed impersonation roles belong.
    organization_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .organization_id = "OrganizationId",
    };
};

pub const ListImpersonationRolesOutput = struct {
    /// The token to retrieve the next page of results. The value is `null` when
    /// there are no results to return.
    next_token: ?[]const u8 = null,

    /// The list of impersonation roles under the given WorkMail organization.
    roles: ?[]const ImpersonationRole = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .roles = "Roles",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListImpersonationRolesInput, options: CallOptions) !ListImpersonationRolesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListImpersonationRolesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.ListImpersonationRoles");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListImpersonationRolesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListImpersonationRolesOutput, body, allocator);
}
