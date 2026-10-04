const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MemberPermissions = @import("member_permissions.zig").MemberPermissions;
const EnvironmentMember = @import("environment_member.zig").EnvironmentMember;

pub const UpdateEnvironmentMembershipInput = struct {
    /// The ID of the environment for the environment member whose settings you want
    /// to
    /// change.
    environment_id: []const u8,

    /// The replacement type of environment member permissions you want to associate
    /// with this
    /// environment member. Available values include:
    ///
    /// * `read-only`: Has read-only access to the environment.
    ///
    /// * `read-write`: Has read-write access to the environment.
    permissions: MemberPermissions,

    /// The Amazon Resource Name (ARN) of the environment member whose settings you
    /// want to
    /// change.
    user_arn: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
        .permissions = "permissions",
        .user_arn = "userArn",
    };
};

pub const UpdateEnvironmentMembershipOutput = struct {
    /// Information about the environment member whose settings were changed.
    membership: ?EnvironmentMember = null,

    pub const json_field_names = .{
        .membership = "membership",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEnvironmentMembershipInput, options: CallOptions) !UpdateEnvironmentMembershipOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEnvironmentMembershipInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCloud9WorkspaceManagementService.UpdateEnvironmentMembership");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEnvironmentMembershipOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateEnvironmentMembershipOutput, body, allocator);
}
