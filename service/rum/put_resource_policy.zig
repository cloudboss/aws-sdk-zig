const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutResourcePolicyInput = struct {
    /// The name of the app monitor that you want to apply this resource-based
    /// policy to. To find the names of your app monitors, you can use the
    /// [ListAppMonitors](https://docs.aws.amazon.com/cloudwatchrum/latest/APIReference/API_ListAppMonitors.html) operation.
    name: []const u8,

    /// The JSON to use as the resource policy. The document can be up to 4 KB in
    /// size. For more information about the contents and syntax for this policy,
    /// see [Using resource-based policies with CloudWatch
    /// RUM](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-RUM-resource-policies.html).
    policy_document: []const u8,

    /// A string value that you can use to conditionally update your policy. You can
    /// provide the revision ID of your existing policy to make mutating requests
    /// against that policy.
    ///
    /// When you assign a policy revision ID, then later requests about that policy
    /// will be rejected with an `InvalidPolicyRevisionIdException` error if they
    /// don't provide the correct current revision ID.
    policy_revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .policy_document = "PolicyDocument",
        .policy_revision_id = "PolicyRevisionId",
    };
};

pub const PutResourcePolicyOutput = struct {
    /// The JSON policy document that you specified.
    policy_document: ?[]const u8 = null,

    /// The policy revision ID information that you specified.
    policy_revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy_document = "PolicyDocument",
        .policy_revision_id = "PolicyRevisionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourcePolicyInput, options: CallOptions) !PutResourcePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rum", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("rum", "RUM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/appmonitor/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/policy");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PolicyDocument\":");
    try aws.json.writeValue(@TypeOf(input.policy_document), input.policy_document, allocator, &body_buf);
    has_prev = true;
    if (input.policy_revision_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PolicyRevisionId\":");
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
