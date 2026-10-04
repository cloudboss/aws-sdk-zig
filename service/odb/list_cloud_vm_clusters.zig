const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CloudVmClusterSummary = @import("cloud_vm_cluster_summary.zig").CloudVmClusterSummary;

pub const ListCloudVmClustersInput = struct {
    /// The unique identifier of the Oracle Exadata infrastructure.
    cloud_exadata_infrastructure_id: ?[]const u8 = null,

    /// The maximum number of items to return for this request. To get the next page
    /// of items, make another request with the token returned in the output.
    ///
    /// Default: `10`
    max_results: ?i32 = null,

    /// The token returned from a previous paginated request. Pagination continues
    /// from the end of the items returned by the previous request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_exadata_infrastructure_id = "cloudExadataInfrastructureId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListCloudVmClustersOutput = struct {
    /// The list of VM clusters along with their properties.
    cloud_vm_clusters: ?[]const CloudVmClusterSummary = null,

    /// The token to include in another request to get the next page of items. This
    /// value is `null` when there are no more items to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_vm_clusters = "cloudVmClusters",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCloudVmClustersInput, options: CallOptions) !ListCloudVmClustersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "odb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCloudVmClustersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("odb", "odb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Odb.ListCloudVmClusters");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCloudVmClustersOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListCloudVmClustersOutput, body, allocator);
}
