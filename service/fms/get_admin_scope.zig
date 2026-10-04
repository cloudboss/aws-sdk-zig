const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdminScope = @import("admin_scope.zig").AdminScope;
const OrganizationStatus = @import("organization_status.zig").OrganizationStatus;

pub const GetAdminScopeInput = struct {
    /// The administrator account that you want to get the details for.
    admin_account: []const u8,

    pub const json_field_names = .{
        .admin_account = "AdminAccount",
    };
};

pub const GetAdminScopeOutput = struct {
    /// Contains details about the administrative scope of the requested account.
    admin_scope: ?AdminScope = null,

    /// The current status of the request to onboard a member account as an Firewall
    /// Manager administrator.
    ///
    /// * `ONBOARDING` - The account is onboarding to Firewall Manager as an
    ///   administrator.
    ///
    /// * `ONBOARDING_COMPLETE` - Firewall Manager The account is onboarded to
    ///   Firewall Manager as an administrator, and can perform actions on the
    ///   resources defined in their AdminScope.
    ///
    /// * `OFFBOARDING` - The account is being removed as an Firewall Manager
    ///   administrator.
    ///
    /// * `OFFBOARDING_COMPLETE` - The account has been removed as an Firewall
    ///   Manager administrator.
    status: ?OrganizationStatus = null,

    pub const json_field_names = .{
        .admin_scope = "AdminScope",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAdminScopeInput, options: CallOptions) !GetAdminScopeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAdminScopeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fms", "FMS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSFMS_20180101.GetAdminScope");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAdminScopeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetAdminScopeOutput, body, allocator);
}
