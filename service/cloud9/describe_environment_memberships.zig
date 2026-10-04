const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Permissions = @import("permissions.zig").Permissions;
const EnvironmentMember = @import("environment_member.zig").EnvironmentMember;

pub const DescribeEnvironmentMembershipsInput = struct {
    /// The ID of the environment to get environment member information about.
    environment_id: ?[]const u8 = null,

    /// The maximum number of environment members to get information about.
    max_results: ?i32 = null,

    /// During a previous call, if there are more than 25 items in the list, only
    /// the first 25
    /// items are returned, along with a unique string called a *next token*. To
    /// get the next batch of items in the list, call this operation again, adding
    /// the next token to
    /// the call. To get all of the items in the list, keep calling this operation
    /// with each
    /// subsequent next token that is returned, until no more next tokens are
    /// returned.
    next_token: ?[]const u8 = null,

    /// The type of environment member permissions to get information about.
    /// Available values
    /// include:
    ///
    /// * `owner`: Owns the environment.
    ///
    /// * `read-only`: Has read-only access to the environment.
    ///
    /// * `read-write`: Has read-write access to the environment.
    ///
    /// If no value is specified, information about all environment members are
    /// returned.
    permissions: ?[]const Permissions = null,

    /// The Amazon Resource Name (ARN) of an individual environment member to get
    /// information
    /// about. If no value is specified, information about all environment members
    /// are
    /// returned.
    user_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .environment_id = "environmentId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .permissions = "permissions",
        .user_arn = "userArn",
    };
};

pub const DescribeEnvironmentMembershipsOutput = struct {
    /// Information about the environment members for the environment.
    memberships: ?[]const EnvironmentMember = null,

    /// If there are more than 25 items in the list, only the first 25 items are
    /// returned, along
    /// with a unique string called a *next token*. To get the next batch of items
    /// in the list, call this operation again, adding the next token to the call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .memberships = "memberships",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEnvironmentMembershipsInput, options: CallOptions) !DescribeEnvironmentMembershipsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloud9", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEnvironmentMembershipsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloud9", "Cloud9", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCloud9WorkspaceManagementService.DescribeEnvironmentMemberships");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEnvironmentMembershipsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeEnvironmentMembershipsOutput, body, allocator);
}
