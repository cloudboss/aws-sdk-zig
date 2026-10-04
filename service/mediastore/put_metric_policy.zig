const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetricPolicy = @import("metric_policy.zig").MetricPolicy;

pub const PutMetricPolicyInput = struct {
    /// The name of the container that you want to add the metric policy to.
    container_name: []const u8,

    /// The metric policy that you want to associate with the container. In the
    /// policy, you must indicate whether you want MediaStore to send
    /// container-level metrics. You can also include up to five rules to define
    /// groups of objects that you want MediaStore to send object-level metrics for.
    /// If you include rules in the policy, construct each rule with both of the
    /// following:
    ///
    /// * An object group that defines which objects to include in the group. The
    ///   definition can be a path or a file name, but it can't have more than 900
    ///   characters. Valid characters are: a-z, A-Z, 0-9, _ (underscore), =
    ///   (equal), : (colon), . (period), - (hyphen), ~ (tilde), / (forward slash),
    ///   and * (asterisk). Wildcards (*) are acceptable.
    ///
    /// * An object group name that allows you to refer to the object group. The
    ///   name can't have more than 30 characters. Valid characters are: a-z, A-Z,
    ///   0-9, and _ (underscore).
    metric_policy: MetricPolicy,

    pub const json_field_names = .{
        .container_name = "ContainerName",
        .metric_policy = "MetricPolicy",
    };
};

pub const PutMetricPolicyOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutMetricPolicyInput, options: CallOptions) !PutMetricPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutMetricPolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MediaStore_20170901.PutMetricPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutMetricPolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
