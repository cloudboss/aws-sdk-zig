const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateAdminAccountInput = struct {
    /// The Amazon Web Services account ID to associate with Firewall Manager as the
    /// Firewall Manager
    /// default administrator account. This account must be
    /// a member account of the organization in Organizations whose resources you
    /// want to protect.
    /// For more information about Organizations, see
    /// [Managing the Amazon Web Services Accounts in Your
    /// Organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts.html).
    admin_account: []const u8,

    pub const json_field_names = .{
        .admin_account = "AdminAccount",
    };
};

pub const AssociateAdminAccountOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateAdminAccountInput, options: CallOptions) !AssociateAdminAccountOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateAdminAccountInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSFMS_20180101.AssociateAdminAccount");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateAdminAccountOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
