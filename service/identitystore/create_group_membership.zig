const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MemberId = @import("member_id.zig").MemberId;

pub const CreateGroupMembershipInput = struct {
    /// The identifier for a group in the identity store.
    group_id: []const u8,

    /// The globally unique identifier for the identity store.
    identity_store_id: []const u8,

    /// An object that contains the identifier of a group member. Setting the
    /// `UserID` field to the specific identifier for a user indicates that the user
    /// is a member of the group.
    member_id: MemberId,

    pub const json_field_names = .{
        .group_id = "GroupId",
        .identity_store_id = "IdentityStoreId",
        .member_id = "MemberId",
    };
};

pub const CreateGroupMembershipOutput = struct {
    /// The globally unique identifier for the identity store.
    identity_store_id: []const u8,

    /// The identifier for a newly created `GroupMembership` in an identity store.
    membership_id: []const u8,

    pub const json_field_names = .{
        .identity_store_id = "IdentityStoreId",
        .membership_id = "MembershipId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGroupMembershipInput, options: CallOptions) !CreateGroupMembershipOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGroupMembershipInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSIdentityStore.CreateGroupMembership");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGroupMembershipOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateGroupMembershipOutput, body, allocator);
}
