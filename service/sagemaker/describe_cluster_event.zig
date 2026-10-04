const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterEventDetail = @import("cluster_event_detail.zig").ClusterEventDetail;

pub const DescribeClusterEventInput = struct {
    /// The name or Amazon Resource Name (ARN) of the HyperPod cluster associated
    /// with the event.
    cluster_name: []const u8,

    /// The unique identifier (UUID) of the event to describe. This ID can be
    /// obtained from the `ListClusterEvents` operation.
    event_id: []const u8,

    pub const json_field_names = .{
        .cluster_name = "ClusterName",
        .event_id = "EventId",
    };
};

pub const DescribeClusterEventOutput = struct {
    /// Detailed information about the requested cluster event, including event
    /// metadata for various resource types such as `Cluster`, `InstanceGroup`,
    /// `Instance`, and their associated attributes.
    event_details: ?ClusterEventDetail = null,

    pub const json_field_names = .{
        .event_details = "EventDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeClusterEventInput, options: CallOptions) !DescribeClusterEventOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeClusterEventInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeClusterEvent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeClusterEventOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeClusterEventOutput, body, allocator);
}
