const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MemberId = @import("member_id.zig").MemberId;
const GroupMembershipExistenceResult = @import("group_membership_existence_result.zig").GroupMembershipExistenceResult;

pub const IsMemberInGroupsInput = struct {
    /// A list of identifiers for groups in the identity store.
    group_ids: []const []const u8,

    /// The globally unique identifier for the identity store.
    identity_store_id: []const u8,

    /// An object containing the identifier of a group member.
    member_id: MemberId,

    pub const json_field_names = .{
        .group_ids = "GroupIds",
        .identity_store_id = "IdentityStoreId",
        .member_id = "MemberId",
    };
};

pub const IsMemberInGroupsOutput = struct {
    /// A list containing the results of membership existence checks.
    results: ?[]const GroupMembershipExistenceResult = null,

    pub const json_field_names = .{
        .results = "Results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: IsMemberInGroupsInput, options: CallOptions) !IsMemberInGroupsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: IsMemberInGroupsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSIdentityStore.IsMemberInGroups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !IsMemberInGroupsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(IsMemberInGroupsOutput, body, allocator);
}
