const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeregisterDelegatedAdministratorInput = struct {
    /// The account ID number of the member account in the organization that you
    /// want to
    /// deregister as a delegated administrator.
    account_id: []const u8,

    /// The service principal name of an Amazon Web Services service for which the
    /// account is a delegated
    /// administrator.
    ///
    /// Delegated administrator privileges are revoked for only the specified Amazon
    /// Web Services service
    /// from the member account. If the specified service is the only service for
    /// which the
    /// member account is a delegated administrator, the operation also revokes
    /// Organizations read action
    /// permissions.
    service_principal: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .service_principal = "ServicePrincipal",
    };
};

pub const DeregisterDelegatedAdministratorOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeregisterDelegatedAdministratorInput, options: CallOptions) !DeregisterDelegatedAdministratorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "organizations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeregisterDelegatedAdministratorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("organizations", "Organizations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.DeregisterDelegatedAdministrator");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeregisterDelegatedAdministratorOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
