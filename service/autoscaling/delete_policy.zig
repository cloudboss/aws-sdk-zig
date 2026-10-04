const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeletePolicyInput = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: ?[]const u8 = null,

    /// The name or Amazon Resource Name (ARN) of the policy.
    policy_name: []const u8,
};

pub const DeletePolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeletePolicyInput, options: CallOptions) !DeletePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "autoscaling", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeletePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeletePolicy&Version=2011-01-01");
    if (input.auto_scaling_group_name) |v| {
        try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&PolicyName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.policy_name);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeletePolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: DeletePolicyOutput = .{};

    return result;
}
