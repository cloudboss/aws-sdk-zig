const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AggregationType = @import("aggregation_type.zig").AggregationType;
const FleetMetricUnit = @import("fleet_metric_unit.zig").FleetMetricUnit;

pub const DescribeFleetMetricInput = struct {
    /// The name of the fleet metric to describe.
    metric_name: []const u8,

    pub const json_field_names = .{
        .metric_name = "metricName",
    };
};

pub const DescribeFleetMetricOutput = struct {
    /// The field to aggregate.
    aggregation_field: ?[]const u8 = null,

    /// The type of the aggregation query.
    aggregation_type: ?AggregationType = null,

    /// The date when the fleet metric is created.
    creation_date: ?i64 = null,

    /// The fleet metric description.
    description: ?[]const u8 = null,

    /// The name of the index to search.
    index_name: ?[]const u8 = null,

    /// The date when the fleet metric is last modified.
    last_modified_date: ?i64 = null,

    /// The ARN of the fleet metric to describe.
    metric_arn: ?[]const u8 = null,

    /// The name of the fleet metric to describe.
    metric_name: ?[]const u8 = null,

    /// The time in seconds between fleet metric emissions. Range [60(1 min),
    /// 86400(1 day)] and must be multiple of 60.
    period: ?i32 = null,

    /// The search query string.
    query_string: ?[]const u8 = null,

    /// The query version.
    query_version: ?[]const u8 = null,

    /// Used to support unit transformation such as milliseconds to seconds. The
    /// unit must be
    /// supported by [CW
    /// metric](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_MetricDatum.html).
    unit: ?FleetMetricUnit = null,

    /// The version of the fleet metric.
    version: ?i64 = null,

    pub const json_field_names = .{
        .aggregation_field = "aggregationField",
        .aggregation_type = "aggregationType",
        .creation_date = "creationDate",
        .description = "description",
        .index_name = "indexName",
        .last_modified_date = "lastModifiedDate",
        .metric_arn = "metricArn",
        .metric_name = "metricName",
        .period = "period",
        .query_string = "queryString",
        .query_version = "queryVersion",
        .unit = "unit",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFleetMetricInput, options: CallOptions) !DescribeFleetMetricOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFleetMetricInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/fleet-metric/");
    try path_buf.appendSlice(allocator, input.metric_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFleetMetricOutput {
    var result: DescribeFleetMetricOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeFleetMetricOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
