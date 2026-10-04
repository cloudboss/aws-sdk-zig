const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthPolicyState = @import("auth_policy_state.zig").AuthPolicyState;

pub const GetAuthPolicyInput = struct {
    /// The ID or ARN of the service network or service.
    resource_identifier: []const u8,

    pub const json_field_names = .{
        .resource_identifier = "resourceIdentifier",
    };
};

pub const GetAuthPolicyOutput = struct {
    /// The date and time that the auth policy was created, in ISO-8601 format.
    created_at: ?i64 = null,

    /// The date and time that the auth policy was last updated, in ISO-8601 format.
    last_updated_at: ?i64 = null,

    /// The auth policy.
    policy: ?[]const u8 = null,

    /// The state of the auth policy. The auth policy is only active when the auth
    /// type is set to `AWS_IAM`. If you provide a policy, then authentication and
    /// authorization decisions are made based on this policy and the client's IAM
    /// policy. If the auth type is `NONE`, then any auth policy that you provide
    /// remains inactive. For more information, see [Create a service
    /// network](https://docs.aws.amazon.com/vpc-lattice/latest/ug/service-networks.html#create-service-network) in the *Amazon VPC Lattice User Guide*.
    state: ?AuthPolicyState = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .last_updated_at = "lastUpdatedAt",
        .policy = "policy",
        .state = "state",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAuthPolicyInput, options: CallOptions) !GetAuthPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "vpc-lattice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAuthPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/authpolicy/");
    try path_buf.appendSlice(allocator, input.resource_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAuthPolicyOutput {
    const result: GetAuthPolicyOutput = try aws.json.parseJsonObject(
        GetAuthPolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
