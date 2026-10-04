const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdminScope = @import("admin_scope.zig").AdminScope;

pub const PutAdminAccountInput = struct {
    /// The Amazon Web Services account ID to add as an Firewall Manager
    /// administrator account. The account must be a member of the organization that
    /// was onboarded to Firewall Manager by AssociateAdminAccount. For more
    /// information about Organizations, see
    /// [Managing the Amazon Web Services Accounts in Your
    /// Organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts.html).
    admin_account: []const u8,

    /// Configures the resources that the specified Firewall Manager administrator
    /// can manage. As a best practice, set the administrative scope according to
    /// the principles of least privilege. Only grant the administrator the specific
    /// resources or permissions that they need to perform the duties of their role.
    admin_scope: ?AdminScope = null,

    pub const json_field_names = .{
        .admin_account = "AdminAccount",
        .admin_scope = "AdminScope",
    };
};

pub const PutAdminAccountOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAdminAccountInput, options: CallOptions) !PutAdminAccountOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAdminAccountInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSFMS_20180101.PutAdminAccount");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAdminAccountOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
