const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateLBCookieStickinessPolicyInput = struct {
    /// The time period, in seconds, after which the cookie should be considered
    /// stale. If you do not specify this parameter, the default value is 0, which
    /// indicates that the sticky session should last for the duration of the
    /// browser session.
    cookie_expiration_period: ?i64 = null,

    /// The name of the load balancer.
    load_balancer_name: []const u8,

    /// The name of the policy being created. Policy names must consist of
    /// alphanumeric characters and dashes (-). This name must be unique within the
    /// set of policies for this load balancer.
    policy_name: []const u8,
};

pub const CreateLBCookieStickinessPolicyOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLBCookieStickinessPolicyInput, options: CallOptions) !CreateLBCookieStickinessPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLBCookieStickinessPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateLBCookieStickinessPolicy&Version=2012-06-01");
    if (input.cookie_expiration_period) |v| {
        try body_buf.appendSlice(allocator, "&CookieExpirationPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&LoadBalancerName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.load_balancer_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLBCookieStickinessPolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: CreateLBCookieStickinessPolicyOutput = .{};

    return result;
}
