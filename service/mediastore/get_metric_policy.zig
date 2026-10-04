const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetricPolicy = @import("metric_policy.zig").MetricPolicy;

pub const GetMetricPolicyInput = struct {
    /// The name of the container that is associated with the metric policy.
    container_name: []const u8,

    pub const json_field_names = .{
        .container_name = "ContainerName",
    };
};

pub const GetMetricPolicyOutput = struct {
    /// The metric policy that is associated with the specific container.
    metric_policy: ?MetricPolicy = null,

    pub const json_field_names = .{
        .metric_policy = "MetricPolicy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMetricPolicyInput, options: CallOptions) !GetMetricPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediastore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMetricPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediastore", "MediaStore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "MediaStore_20170901.GetMetricPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMetricPolicyOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetMetricPolicyOutput, body, allocator);
}
