const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserType = @import("user_type.zig").UserType;

pub const ListUsersInGroupInput = struct {
    /// The name of the group that you want to query for user membership.
    group_name: []const u8,

    /// The maximum number of groups that you want Amazon Cognito to return in the
    /// response. In some
    /// SDK contexts, this operation might return fewer items than you specify in
    /// the
    /// `Limit` parameter without having reached the end of the full list. If the
    /// response contains a `PaginationToken`, then there are more results.
    limit: ?i32 = null,

    /// This API operation returns a limited number of results. The pagination token
    /// is
    /// an identifier that you can present in an additional API request with the
    /// same parameters. When
    /// you include the pagination token, Amazon Cognito returns the next set of
    /// items after the current list.
    /// Subsequent requests return a new pagination token. By use of this token, you
    /// can paginate
    /// through the full list of items.
    next_token: ?[]const u8 = null,

    /// The ID of the user pool where you want to view the membership of the
    /// requested
    /// group.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .group_name = "GroupName",
        .limit = "Limit",
        .next_token = "NextToken",
        .user_pool_id = "UserPoolId",
    };
};

pub const ListUsersInGroupOutput = struct {
    /// The identifier that Amazon Cognito returned with the previous request to
    /// this operation. When
    /// you include a pagination token in your request, Amazon Cognito returns the
    /// next set of items in
    /// the list. By use of this token, you can paginate through the full list of
    /// items.
    next_token: ?[]const u8 = null,

    /// An array of users who are members in the group, and their attributes.
    users: ?[]const UserType = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .users = "Users",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListUsersInGroupInput, options: CallOptions) !ListUsersInGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-idp", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListUsersInGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-idp", "Cognito Identity Provider", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.ListUsersInGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListUsersInGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListUsersInGroupOutput, body, allocator);
}
