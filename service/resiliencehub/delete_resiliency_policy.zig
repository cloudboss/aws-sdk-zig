const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteResiliencyPolicyInput = struct {
    /// Used for an idempotency token. A client token is a unique, case-sensitive
    /// string of up to 64 ASCII characters.
    /// You should not reuse the same client token for other API requests.
    client_token: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of the resiliency policy. The format for this ARN
    /// is:
    /// arn:`partition`:resiliencehub:`region`:`account`:resiliency-policy/`policy-id`. For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    policy_arn: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .policy_arn = "policyArn",
    };
};

pub const DeleteResiliencyPolicyOutput = struct {
    /// Amazon Resource Name (ARN) of the resiliency policy. The format for this ARN
    /// is:
    /// arn:`partition`:resiliencehub:`region`:`account`:resiliency-policy/`policy-id`. For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    policy_arn: []const u8,

    pub const json_field_names = .{
        .policy_arn = "policyArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteResiliencyPolicyInput, options: CallOptions) !DeleteResiliencyPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteResiliencyPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/delete-resiliency-policy";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyArn\":");
    try aws.json.writeValue(@TypeOf(input.policy_arn), input.policy_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteResiliencyPolicyOutput {
    var result: DeleteResiliencyPolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteResiliencyPolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
