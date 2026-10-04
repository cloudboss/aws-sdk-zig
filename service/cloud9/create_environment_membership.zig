const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MemberPermissions = @import("member_permissions.zig").MemberPermissions;
const EnvironmentMember = @import("environment_member.zig").EnvironmentMember;

pub const CreateEnvironmentMembershipInput = struct {
    /// The ID of the environment that contains the environment member you want to
    /// add.
    environment_id: []const u8,

    /// The type of environment member permissions you want to associate with this
    /// environment
    /// member. Available values include:
    ///
    /// * `read-only`: Has read-only access to the environment.
    ///
    /// * `read-write`: Has read-write access to the environment.
    permissions: MemberPermissions,

    /// The Amazon Resource Name (ARN) of the environment member you want to add.
    user_arn: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
        .permissions = "permissions",
        .user_arn = "userArn",
    };
};

pub const CreateEnvironmentMembershipOutput = struct {
    /// Information about the environment member that was added.
    membership: ?EnvironmentMember = null,

    pub const json_field_names = .{
        .membership = "membership",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnvironmentMembershipInput, options: CallOptions) !CreateEnvironmentMembershipOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEnvironmentMembershipInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCloud9WorkspaceManagementService.CreateEnvironmentMembership");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEnvironmentMembershipOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateEnvironmentMembershipOutput, body, allocator);
}
