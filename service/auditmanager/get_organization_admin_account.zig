const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetOrganizationAdminAccountInput = struct {
};

pub const GetOrganizationAdminAccountOutput = struct {
    /// The identifier for the administrator account.
    admin_account_id: ?[]const u8 = null,

    /// The identifier for the organization.
    organization_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .admin_account_id = "adminAccountId",
        .organization_id = "organizationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOrganizationAdminAccountInput, options: CallOptions) !GetOrganizationAdminAccountOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "auditmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOrganizationAdminAccountInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/account/organizationAdminAccount";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOrganizationAdminAccountOutput {
    var result: GetOrganizationAdminAccountOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetOrganizationAdminAccountOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
