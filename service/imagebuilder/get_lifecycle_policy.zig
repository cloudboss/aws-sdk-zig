const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LifecyclePolicy = @import("lifecycle_policy.zig").LifecyclePolicy;

pub const GetLifecyclePolicyInput = struct {
    /// Specifies the Amazon Resource Name (ARN) of the image lifecycle policy
    /// resource to get.
    lifecycle_policy_arn: []const u8,

    pub const json_field_names = .{
        .lifecycle_policy_arn = "lifecyclePolicyArn",
    };
};

pub const GetLifecyclePolicyOutput = struct {
    /// The Amazon Resource Name (ARN) of the image lifecycle policy resource that
    /// was returned.
    lifecycle_policy: ?LifecyclePolicy = null,

    pub const json_field_names = .{
        .lifecycle_policy = "lifecyclePolicy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLifecyclePolicyInput, options: CallOptions) !GetLifecyclePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "imagebuilder", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLifecyclePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetLifecyclePolicy";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "lifecyclePolicyArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.lifecycle_policy_arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLifecyclePolicyOutput {
    var result: GetLifecyclePolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetLifecyclePolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
