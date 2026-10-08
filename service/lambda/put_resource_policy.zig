const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutResourcePolicyInput = struct {
    /// The policy document you want to add to your Lambda resource. This is
    /// formatted as a JSON string.
    ///
    /// For more information, see [Working with resource-based policies in
    /// Lambda](https://docs.aws.amazon.com/lambda/latest/dg/access-control-resource-based.html) in the *Lambda Developer Guide*.
    policy: []const u8,

    /// The Amazon Resource Name (ARN) of the Lambda resource you want to add the
    /// policy to. You can use a qualified or an unqualified ARN. The value must be
    /// a complete ARN, and the operation does not accept wildcard characters.
    resource_arn: []const u8,

    /// The revision ID that the existing policy must match for the replacement to
    /// proceed. If the revision ID doesn't match, the operation fails with a
    /// `PreconditionFailedException` error. To retrieve the current revision ID,
    /// use the GetResourcePolicy operation.
    revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy = "Policy",
        .resource_arn = "ResourceArn",
        .revision_id = "RevisionId",
    };
};

pub const PutResourcePolicyOutput = struct {
    /// The resource-based policy that Lambda adds to the resource.
    policy: ?[]const u8 = null,

    /// The revision ID of the policy that Lambda adds to your Lambda resource.
    revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy = "Policy",
        .revision_id = "RevisionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourcePolicyInput, options: CallOptions) !PutResourcePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutResourcePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2026-07-09/resource-policy/");
    try path_buf.appendSlice(allocator, input.resource_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Policy\":");
    try aws.json.writeValue(@TypeOf(input.policy), input.policy, allocator, &body_buf);
    has_prev = true;
    if (input.revision_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RevisionId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutResourcePolicyOutput {
    const result: PutResourcePolicyOutput = try aws.json.parseJsonObject(
        PutResourcePolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
