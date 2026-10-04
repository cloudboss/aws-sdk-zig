const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupType = @import("group_type.zig").GroupType;

pub const UpdateGroupInput = struct {
    /// A new description of the existing group.
    description: ?[]const u8 = null,

    /// The name of the group that you want to update.
    group_name: []const u8,

    /// A non-negative integer value that specifies the precedence of this group
    /// relative to
    /// the other groups that a user can belong to in the user pool. Zero is the
    /// highest
    /// precedence value. Groups with lower `Precedence` values take precedence over
    /// groups with higher or null `Precedence` values. If a user belongs to two or
    /// more groups, it is the group with the lowest precedence value whose role ARN
    /// is given in
    /// the user's tokens for the `cognito:roles` and
    /// `cognito:preferred_role` claims.
    ///
    /// Two groups can have the same `Precedence` value. If this happens, neither
    /// group takes precedence over the other. If two groups with the same
    /// `Precedence` have the same role ARN, that role is used in the
    /// `cognito:preferred_role` claim in tokens for users in each group. If the
    /// two groups have different role ARNs, the `cognito:preferred_role` claim
    /// isn't
    /// set in users' tokens.
    ///
    /// The default `Precedence` value is null. The maximum `Precedence`
    /// value is `2^31-1`.
    precedence: ?i32 = null,

    /// The Amazon Resource Name (ARN) of an IAM role that you want to associate
    /// with the
    /// group. The role assignment contributes to the `cognito:roles` and
    /// `cognito:preferred_role` claims in group members' tokens.
    role_arn: ?[]const u8 = null,

    /// The ID of the user pool that contains the group you want to update.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .group_name = "GroupName",
        .precedence = "Precedence",
        .role_arn = "RoleArn",
        .user_pool_id = "UserPoolId",
    };
};

pub const UpdateGroupOutput = struct {
    /// Contains the updated details of the group, including precedence, IAM role,
    /// and
    /// description.
    group: ?GroupType = null,

    pub const json_field_names = .{
        .group = "Group",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGroupInput, options: CallOptions) !UpdateGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.UpdateGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateGroupOutput, body, allocator);
}
