const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DbInstanceForClusterSummary = @import("db_instance_for_cluster_summary.zig").DbInstanceForClusterSummary;

pub const ListDbInstancesForClusterInput = struct {
    /// Service-generated unique identifier of the DB cluster.
    db_cluster_id: []const u8,

    /// The maximum number of items to return in the output. If the total number of
    /// items available is more than the value specified, a nextToken is provided in
    /// the output. To resume pagination, provide the nextToken value as an argument
    /// of a subsequent API invocation.
    max_results: ?i32 = null,

    /// The pagination token. To resume pagination, provide the nextToken value as
    /// an argument of a subsequent API invocation.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .db_cluster_id = "dbClusterId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListDbInstancesForClusterOutput = struct {
    /// A list of Timestream for InfluxDB instance summaries belonging to the
    /// cluster.
    items: ?[]const DbInstanceForClusterSummary = null,

    /// Token from a previous call of the operation. When this value is provided,
    /// the
    /// service returns results from where the previous response left off.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDbInstancesForClusterInput, options: CallOptions) !ListDbInstancesForClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "timestream-influxdb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDbInstancesForClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("timestream-influxdb", "Timestream InfluxDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonTimestreamInfluxDB.ListDbInstancesForCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDbInstancesForClusterOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListDbInstancesForClusterOutput, body, allocator);
}
