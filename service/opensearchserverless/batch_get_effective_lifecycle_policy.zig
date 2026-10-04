const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LifecyclePolicyResourceIdentifier = @import("lifecycle_policy_resource_identifier.zig").LifecyclePolicyResourceIdentifier;
const EffectiveLifecyclePolicyDetail = @import("effective_lifecycle_policy_detail.zig").EffectiveLifecyclePolicyDetail;
const EffectiveLifecyclePolicyErrorDetail = @import("effective_lifecycle_policy_error_detail.zig").EffectiveLifecyclePolicyErrorDetail;

pub const BatchGetEffectiveLifecyclePolicyInput = struct {
    /// The unique identifiers of policy types and resource names.
    resource_identifiers: []const LifecyclePolicyResourceIdentifier,

    pub const json_field_names = .{
        .resource_identifiers = "resourceIdentifiers",
    };
};

pub const BatchGetEffectiveLifecyclePolicyOutput = struct {
    /// A list of lifecycle policies applied to the OpenSearch Serverless indexes.
    effective_lifecycle_policy_details: ?[]const EffectiveLifecyclePolicyDetail = null,

    /// A list of resources for which retrieval failed.
    effective_lifecycle_policy_error_details: ?[]const EffectiveLifecyclePolicyErrorDetail = null,

    pub const json_field_names = .{
        .effective_lifecycle_policy_details = "effectiveLifecyclePolicyDetails",
        .effective_lifecycle_policy_error_details = "effectiveLifecyclePolicyErrorDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetEffectiveLifecyclePolicyInput, options: CallOptions) !BatchGetEffectiveLifecyclePolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetEffectiveLifecyclePolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "OpenSearchServerless.BatchGetEffectiveLifecyclePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetEffectiveLifecyclePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetEffectiveLifecyclePolicyOutput, body, allocator);
}
