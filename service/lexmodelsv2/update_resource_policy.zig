const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateResourcePolicyInput = struct {
    /// The identifier of the revision of the policy to update. If this
    /// revision ID doesn't match the current revision ID, Amazon Lex throws an
    /// exception.
    ///
    /// If you don't specify a revision, Amazon Lex overwrites the contents of
    /// the policy with the new values.
    expected_revision_id: ?[]const u8 = null,

    /// A resource policy to add to the resource. The policy is a JSON
    /// structure that contains one or more statements that define the policy.
    /// The policy must follow the IAM syntax. For more information about the
    /// contents of a JSON policy document, see [ IAM JSON policy
    /// reference
    /// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies.html).
    ///
    /// If the policy isn't valid, Amazon Lex returns a validation
    /// exception.
    policy: []const u8,

    /// The Amazon Resource Name (ARN) of the bot or bot alias that the
    /// resource policy is attached to.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .expected_revision_id = "expectedRevisionId",
        .policy = "policy",
        .resource_arn = "resourceArn",
    };
};

pub const UpdateResourcePolicyOutput = struct {
    /// The Amazon Resource Name (ARN) of the bot or bot alias that the
    /// resource policy is attached to.
    resource_arn: ?[]const u8 = null,

    /// The current revision of the resource policy. Use the revision ID to
    /// make sure that you are updating the most current version of a resource
    /// policy when you add a policy statement to a resource, delete a
    /// resource, or update a resource.
    revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .revision_id = "revisionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateResourcePolicyInput, options: CallOptions) !UpdateResourcePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateResourcePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/policy/");
    try path_buf.appendSlice(allocator, input.resource_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.expected_revision_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "expectedRevisionId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateResourcePolicyOutput {
    const result: UpdateResourcePolicyOutput = try aws.json.parseJsonObject(
        UpdateResourcePolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
