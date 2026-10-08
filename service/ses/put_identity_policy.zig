const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutIdentityPolicyInput = struct {
    /// The identity to which that the policy applies. You can specify an identity
    /// by using
    /// its name or by using its Amazon Resource Name (ARN). Examples:
    /// `user@example.com`, `example.com`,
    /// `arn:aws:ses:us-east-1:123456789012:identity/example.com`.
    ///
    /// To successfully call this operation, you must own the identity.
    identity: []const u8,

    /// The text of the policy in JSON format. The policy cannot exceed 4 KB.
    ///
    /// For information about the syntax of sending authorization policies, see the
    /// [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/sending-authorization-policies.html).
    policy: []const u8,

    /// The name of the policy.
    ///
    /// The policy name cannot exceed 64 characters and can only include
    /// alphanumeric
    /// characters, dashes, and underscores.
    policy_name: []const u8,
};

pub const PutIdentityPolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutIdentityPolicyInput, options: CallOptions) !PutIdentityPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutIdentityPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=PutIdentityPolicy&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&Identity=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.identity);
    try body_buf.appendSlice(allocator, "&Policy=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.policy);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutIdentityPolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: PutIdentityPolicyOutput = .{};

    return result;
}
