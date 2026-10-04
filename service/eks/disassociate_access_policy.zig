const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DisassociateAccessPolicyInput = struct {
    /// The name of your cluster.
    cluster_name: []const u8,

    /// The ARN of the policy to disassociate from the access entry. For a list of
    /// associated policies ARNs, use `ListAssociatedAccessPolicies`.
    policy_arn: []const u8,

    /// The ARN of the IAM principal for the `AccessEntry`.
    principal_arn: []const u8,

    pub const json_field_names = .{
        .cluster_name = "clusterName",
        .policy_arn = "policyArn",
        .principal_arn = "principalArn",
    };
};

pub const DisassociateAccessPolicyOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateAccessPolicyInput, options: CallOptions) !DisassociateAccessPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "eks", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateAccessPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/access-entries/");
    try path_buf.appendSlice(allocator, input.principal_arn);
    try path_buf.appendSlice(allocator, "/access-policies/");
    try path_buf.appendSlice(allocator, input.policy_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateAccessPolicyOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DisassociateAccessPolicyOutput = .{};

    return result;
}
