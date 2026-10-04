const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyAttribute = @import("policy_attribute.zig").PolicyAttribute;
const serde = @import("serde.zig");

pub const CreateLoadBalancerPolicyInput = struct {
    /// The name of the load balancer.
    load_balancer_name: []const u8,

    /// The policy attributes.
    policy_attributes: ?[]const PolicyAttribute = null,

    /// The name of the load balancer policy to be created. This name must be unique
    /// within the set of policies for this load balancer.
    policy_name: []const u8,

    /// The name of the base policy type.
    /// To get the list of policy types, use DescribeLoadBalancerPolicyTypes.
    policy_type_name: []const u8,
};

pub const CreateLoadBalancerPolicyOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLoadBalancerPolicyInput, options: CallOptions) !CreateLoadBalancerPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticloadbalancing", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLoadBalancerPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateLoadBalancerPolicy&Version=2012-06-01");
    try body_buf.appendSlice(allocator, "&LoadBalancerName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.load_balancer_name);
    if (input.policy_attributes) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.attribute_name) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PolicyAttributes.member.{d}.AttributeName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.attribute_value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PolicyAttributes.member.{d}.AttributeValue=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    try body_buf.appendSlice(allocator, "&PolicyName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.policy_name);
    try body_buf.appendSlice(allocator, "&PolicyTypeName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.policy_type_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLoadBalancerPolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: CreateLoadBalancerPolicyOutput = .{};

    return result;
}
