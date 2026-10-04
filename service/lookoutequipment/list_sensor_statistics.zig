const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SensorStatisticsSummary = @import("sensor_statistics_summary.zig").SensorStatisticsSummary;

pub const ListSensorStatisticsInput = struct {
    /// The name of the dataset associated with the list of Sensor Statistics.
    dataset_name: []const u8,

    /// The ingestion job id associated with the list of Sensor Statistics. To get
    /// sensor
    /// statistics for a particular ingestion job id, both dataset name and
    /// ingestion job id must
    /// be submitted as inputs.
    ingestion_job_id: ?[]const u8 = null,

    /// Specifies the maximum number of sensors for which to retrieve statistics.
    max_results: ?i32 = null,

    /// An opaque pagination token indicating where to continue the listing of
    /// sensor
    /// statistics.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_name = "DatasetName",
        .ingestion_job_id = "IngestionJobId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListSensorStatisticsOutput = struct {
    /// An opaque pagination token indicating where to continue the listing of
    /// sensor
    /// statistics.
    next_token: ?[]const u8 = null,

    /// Provides ingestion-based statistics regarding the specified sensor with
    /// respect to
    /// various validation types, such as whether data exists, the number and
    /// percentage of missing
    /// values, and the number and percentage of duplicate timestamps.
    sensor_statistics_summaries: ?[]const SensorStatisticsSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .sensor_statistics_summaries = "SensorStatisticsSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSensorStatisticsInput, options: CallOptions) !ListSensorStatisticsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lookoutequipment", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSensorStatisticsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.ListSensorStatistics");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSensorStatisticsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListSensorStatisticsOutput, body, allocator);
}
