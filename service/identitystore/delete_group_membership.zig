const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteGroupMembershipInput = struct {
    /// The globally unique identifier for the identity store.
    ///
    /// You can specify the identity store by ID or by Amazon Resource Name (ARN).
    /// For example, identity store ID `d-1234567890` or identity store ARN
    /// `arn:aws:identitystore::111122223333:identitystore/d-1234567890`.
    identity_store_id: []const u8,

    /// The identifier for a `GroupMembership` in an identity store.
    ///
    /// You can specify the group membership by ID or by Amazon Resource Name (ARN).
    /// For example, membership ID `a1b2c3d4-5678-90ab-cdef-EXAMPLE33333` or
    /// membership ARN
    /// `arn:aws:identitystore:::membership/a1b2c3d4-5678-90ab-cdef-EXAMPLE33333`.
    membership_id: []const u8,

    pub const json_field_names = .{
        .identity_store_id = "IdentityStoreId",
        .membership_id = "MembershipId",
    };
};

pub const DeleteGroupMembershipOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteGroupMembershipInput, options: CallOptions) !DeleteGroupMembershipOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "identitystore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteGroupMembershipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("identitystore", "identitystore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSIdentityStore.DeleteGroupMembership");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteGroupMembershipOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
