const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateEmailIdentityPolicyInput = struct {
    /// The email identity.
    email_identity: []const u8,

    /// The text of the policy in JSON format. The policy cannot exceed 4 KB.
    ///
    /// For information about the syntax of sending authorization policies, see the
    /// [Amazon SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/sending-authorization-policies.html).
    policy: []const u8,

    /// The name of the policy.
    ///
    /// The policy name cannot exceed 64 characters and can only include
    /// alphanumeric
    /// characters, dashes, and underscores.
    policy_name: []const u8,

    pub const json_field_names = .{
        .email_identity = "EmailIdentity",
        .policy = "Policy",
        .policy_name = "PolicyName",
    };
};

pub const CreateEmailIdentityPolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEmailIdentityPolicyInput, options: CallOptions) !CreateEmailIdentityPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEmailIdentityPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/identities/");
    try path_buf.appendSlice(allocator, input.email_identity);
    try path_buf.appendSlice(allocator, "/policies/");
    try path_buf.appendSlice(allocator, input.policy_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Policy\":");
    try aws.json.writeValue(@TypeOf(input.policy), input.policy, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEmailIdentityPolicyOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CreateEmailIdentityPolicyOutput = .{};

    return result;
}
