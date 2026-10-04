const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartAccountAssociationRefreshInput = struct {
    /// The unique identifier of the account association to refresh.
    account_association_id: []const u8,

    pub const json_field_names = .{
        .account_association_id = "AccountAssociationId",
    };
};

pub const StartAccountAssociationRefreshOutput = struct {
    /// Third-party IoT platform OAuth authorization server URL with all required
    /// parameters to perform end-user authentication during the refresh process.
    /// This field will be empty when using General Authorization flows that do not
    /// require OAuth.
    o_auth_authorization_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .o_auth_authorization_url = "OAuthAuthorizationUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAccountAssociationRefreshInput, options: CallOptions) !StartAccountAssociationRefreshOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAccountAssociationRefreshInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/account-associations/");
    try path_buf.appendSlice(allocator, input.account_association_id);
    try path_buf.appendSlice(allocator, "/refresh");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAccountAssociationRefreshOutput {
    const result: StartAccountAssociationRefreshOutput = try aws.json.parseJsonObject(
        StartAccountAssociationRefreshOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
