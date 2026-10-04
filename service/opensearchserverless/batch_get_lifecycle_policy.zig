const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LifecyclePolicyIdentifier = @import("lifecycle_policy_identifier.zig").LifecyclePolicyIdentifier;
const LifecyclePolicyDetail = @import("lifecycle_policy_detail.zig").LifecyclePolicyDetail;
const LifecyclePolicyErrorDetail = @import("lifecycle_policy_error_detail.zig").LifecyclePolicyErrorDetail;

pub const BatchGetLifecyclePolicyInput = struct {
    /// The unique identifiers of policy types and policy names.
    identifiers: []const LifecyclePolicyIdentifier,

    pub const json_field_names = .{
        .identifiers = "identifiers",
    };
};

pub const BatchGetLifecyclePolicyOutput = struct {
    /// A list of lifecycle policies matched to the input policy name and policy
    /// type.
    lifecycle_policy_details: ?[]const LifecyclePolicyDetail = null,

    /// A list of lifecycle policy names and policy types for which retrieval
    /// failed.
    lifecycle_policy_error_details: ?[]const LifecyclePolicyErrorDetail = null,

    pub const json_field_names = .{
        .lifecycle_policy_details = "lifecyclePolicyDetails",
        .lifecycle_policy_error_details = "lifecyclePolicyErrorDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetLifecyclePolicyInput, options: CallOptions) !BatchGetLifecyclePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aoss", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetLifecyclePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aoss", "OpenSearchServerless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "OpenSearchServerless.BatchGetLifecyclePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetLifecyclePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetLifecyclePolicyOutput, body, allocator);
}
