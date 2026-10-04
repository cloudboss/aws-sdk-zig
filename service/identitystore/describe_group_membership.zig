const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MemberId = @import("member_id.zig").MemberId;

pub const DescribeGroupMembershipInput = struct {
    /// The globally unique identifier for the identity store.
    identity_store_id: []const u8,

    /// The identifier for a `GroupMembership` in an identity store.
    membership_id: []const u8,

    pub const json_field_names = .{
        .identity_store_id = "IdentityStoreId",
        .membership_id = "MembershipId",
    };
};

pub const DescribeGroupMembershipOutput = struct {
    /// The date and time the group membership was created.
    created_at: ?i64 = null,

    /// The identifier of the user or system that created the group membership.
    created_by: ?[]const u8 = null,

    /// The identifier for a group in the identity store.
    group_id: []const u8,

    /// The globally unique identifier for the identity store.
    identity_store_id: []const u8,

    member_id: ?MemberId = null,

    /// The identifier for a `GroupMembership` in an identity store.
    membership_id: []const u8,

    /// The date and time the group membership was last updated.
    updated_at: ?i64 = null,

    /// The identifier of the user or system that last updated the group membership.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .created_by = "CreatedBy",
        .group_id = "GroupId",
        .identity_store_id = "IdentityStoreId",
        .member_id = "MemberId",
        .membership_id = "MembershipId",
        .updated_at = "UpdatedAt",
        .updated_by = "UpdatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeGroupMembershipInput, options: CallOptions) !DescribeGroupMembershipOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeGroupMembershipInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSIdentityStore.DescribeGroupMembership");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeGroupMembershipOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeGroupMembershipOutput, body, allocator);
}
