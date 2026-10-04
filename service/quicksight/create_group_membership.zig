const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupMember = @import("group_member.zig").GroupMember;

pub const CreateGroupMembershipInput = struct {
    /// The ID for the Amazon Web Services account that the group is in. Currently,
    /// you use the ID for the
    /// Amazon Web Services account that contains your Amazon Quick Sight account.
    aws_account_id: []const u8,

    /// The name of the group that you want to add the user to.
    group_name: []const u8,

    /// The name of the user that you want to add to the group membership.
    member_name: []const u8,

    /// The namespace that you want the user to be a part of.
    namespace: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .group_name = "GroupName",
        .member_name = "MemberName",
        .namespace = "Namespace",
    };
};

pub const CreateGroupMembershipOutput = struct {
    /// The group member.
    group_member: ?GroupMember = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .group_member = "GroupMember",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGroupMembershipInput, options: CallOptions) !CreateGroupMembershipOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/namespaces/");
    try path_buf.appendSlice(allocator, input.namespace);
    try path_buf.appendSlice(allocator, "/groups/");
    try path_buf.appendSlice(allocator, input.group_name);
    try path_buf.appendSlice(allocator, "/members/");
    try path_buf.appendSlice(allocator, input.member_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGroupMembershipOutput {
    var result: CreateGroupMembershipOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateGroupMembershipOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}
