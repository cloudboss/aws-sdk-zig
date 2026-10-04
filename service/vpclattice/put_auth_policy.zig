const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthPolicyState = @import("auth_policy_state.zig").AuthPolicyState;

pub const PutAuthPolicyInput = struct {
    /// The auth policy. The policy string in JSON must not contain newlines or
    /// blank lines.
    policy: []const u8,

    /// The ID or ARN of the service network or service for which the policy is
    /// created.
    resource_identifier: []const u8,

    pub const json_field_names = .{
        .policy = "policy",
        .resource_identifier = "resourceIdentifier",
    };
};

pub const PutAuthPolicyOutput = struct {
    /// The auth policy. The policy string in JSON must not contain newlines or
    /// blank lines.
    policy: ?[]const u8 = null,

    /// The state of the auth policy. The auth policy is only active when the auth
    /// type is set to `AWS_IAM`. If you provide a policy, then authentication and
    /// authorization decisions are made based on this policy and the client's IAM
    /// policy. If the Auth type is `NONE`, then, any auth policy that you provide
    /// remains inactive. For more information, see [Create a service
    /// network](https://docs.aws.amazon.com/vpc-lattice/latest/ug/service-networks.html#create-service-network) in the *Amazon VPC Lattice User Guide*.
    state: ?AuthPolicyState = null,

    pub const json_field_names = .{
        .policy = "policy",
        .state = "state",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAuthPolicyInput, options: CallOptions) !PutAuthPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAuthPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/authpolicy/");
    try path_buf.appendSlice(allocator, input.resource_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policy\":");
    try aws.json.writeValue(@TypeOf(input.policy), input.policy, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAuthPolicyOutput {
    var result: PutAuthPolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutAuthPolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
