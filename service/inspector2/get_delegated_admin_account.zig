const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DelegatedAdmin = @import("delegated_admin.zig").DelegatedAdmin;

pub const GetDelegatedAdminAccountInput = struct {
};

pub const GetDelegatedAdminAccountOutput = struct {
    /// The Amazon Web Services account ID of the Amazon Inspector delegated
    /// administrator.
    delegated_admin: ?DelegatedAdmin = null,

    pub const json_field_names = .{
        .delegated_admin = "delegatedAdmin",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDelegatedAdminAccountInput, options: CallOptions) !GetDelegatedAdminAccountOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDelegatedAdminAccountInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/delegatedadminaccounts/get";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDelegatedAdminAccountOutput {
    const result: GetDelegatedAdminAccountOutput = try aws.json.parseJsonObject(
        GetDelegatedAdminAccountOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
