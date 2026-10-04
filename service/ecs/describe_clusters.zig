const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterField = @import("cluster_field.zig").ClusterField;
const Cluster = @import("cluster.zig").Cluster;
const Failure = @import("failure.zig").Failure;

pub const DescribeClustersInput = struct {
    /// A list of up to 100 cluster names or full cluster Amazon Resource Name (ARN)
    /// entries. If you do not specify a cluster, the default cluster is assumed.
    clusters: ?[]const []const u8 = null,

    /// Determines whether to include additional information about the clusters in
    /// the response. If this field is omitted, this information isn't included.
    ///
    /// If `ATTACHMENTS` is specified, the attachments for the container instances
    /// or tasks within the cluster are included, for example the capacity
    /// providers.
    ///
    /// If `SETTINGS` is specified, the settings for the cluster are included.
    ///
    /// If `CONFIGURATIONS` is specified, the configuration for the cluster is
    /// included.
    ///
    /// If `STATISTICS` is specified, the task and service count is included,
    /// separated by launch type.
    ///
    /// If `TAGS` is specified, the metadata tags associated with the cluster are
    /// included.
    include: ?[]const ClusterField = null,

    pub const json_field_names = .{
        .clusters = "clusters",
        .include = "include",
    };
};

pub const DescribeClustersOutput = struct {
    /// The list of clusters.
    clusters: ?[]const Cluster = null,

    /// Any failures associated with the call.
    failures: ?[]const Failure = null,

    pub const json_field_names = .{
        .clusters = "clusters",
        .failures = "failures",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeClustersInput, options: CallOptions) !DescribeClustersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeClustersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.DescribeClusters");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeClustersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeClustersOutput, body, allocator);
}
