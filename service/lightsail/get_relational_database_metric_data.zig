const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RelationalDatabaseMetricName = @import("relational_database_metric_name.zig").RelationalDatabaseMetricName;
const MetricStatistic = @import("metric_statistic.zig").MetricStatistic;
const MetricUnit = @import("metric_unit.zig").MetricUnit;
const MetricDatapoint = @import("metric_datapoint.zig").MetricDatapoint;

pub const GetRelationalDatabaseMetricDataInput = struct {
    /// The end of the time interval from which to get metric data.
    ///
    /// Constraints:
    ///
    /// * Specified in Coordinated Universal Time (UTC).
    ///
    /// * Specified in the Unix time format.
    ///
    /// For example, if you wish to use an end time of October 1, 2018, at 8 PM UTC,
    /// then you
    /// input `1538424000` as the end time.
    end_time: i64,

    /// The metric for which you want to return information.
    ///
    /// Valid relational database metric names are listed below, along with the most
    /// useful
    /// `statistics` to include in your request, and the published `unit`
    /// value. All relational database metric data is available in 1-minute (60
    /// seconds)
    /// granularity.
    ///
    /// * **
    /// `CPUUtilization`
    /// ** - The percentage of CPU
    /// utilization currently in use on the database.
    ///
    /// `Statistics`: The most useful statistics are `Maximum` and
    /// `Average`.
    ///
    /// `Unit`: The published unit is `Percent`.
    ///
    /// * **
    /// `DatabaseConnections`
    /// ** - The number of
    /// database connections in use.
    ///
    /// `Statistics`: The most useful statistics are `Maximum` and
    /// `Sum`.
    ///
    /// `Unit`: The published unit is `Count`.
    ///
    /// * **
    /// `DiskQueueDepth`
    /// ** - The number of
    /// outstanding IOs (read/write requests) that are waiting to access the disk.
    ///
    /// `Statistics`: The most useful statistic is `Sum`.
    ///
    /// `Unit`: The published unit is `Count`.
    ///
    /// * **
    /// `FreeStorageSpace`
    /// ** - The amount of
    /// available storage space.
    ///
    /// `Statistics`: The most useful statistic is `Sum`.
    ///
    /// `Unit`: The published unit is `Bytes`.
    ///
    /// * **
    /// `NetworkReceiveThroughput`
    /// ** - The incoming
    /// (Receive) network traffic on the database, including both customer database
    /// traffic and
    /// AWS traffic used for monitoring and replication.
    ///
    /// `Statistics`: The most useful statistic is `Average`.
    ///
    /// `Unit`: The published unit is `Bytes/Second`.
    ///
    /// * **
    /// `NetworkTransmitThroughput`
    /// ** - The outgoing
    /// (Transmit) network traffic on the database, including both customer database
    /// traffic and
    /// AWS traffic used for monitoring and replication.
    ///
    /// `Statistics`: The most useful statistic is `Average`.
    ///
    /// `Unit`: The published unit is `Bytes/Second`.
    metric_name: RelationalDatabaseMetricName,

    /// The granularity, in seconds, of the returned data points.
    ///
    /// All relational database metric data is available in 1-minute (60 seconds)
    /// granularity.
    period: i32,

    /// The name of your database from which to get metric data.
    relational_database_name: []const u8,

    /// The start of the time interval from which to get metric data.
    ///
    /// Constraints:
    ///
    /// * Specified in Coordinated Universal Time (UTC).
    ///
    /// * Specified in the Unix time format.
    ///
    /// For example, if you wish to use a start time of October 1, 2018, at 8 PM
    /// UTC, then you
    /// input `1538424000` as the start time.
    start_time: i64,

    /// The statistic for the metric.
    ///
    /// The following statistics are available:
    ///
    /// * `Minimum` - The lowest value observed during the specified period. Use
    ///   this
    /// value to determine low volumes of activity for your application.
    ///
    /// * `Maximum` - The highest value observed during the specified period. Use
    /// this value to determine high volumes of activity for your application.
    ///
    /// * `Sum` - All values submitted for the matching metric added together. You
    /// can use this statistic to determine the total volume of a metric.
    ///
    /// * `Average` - The value of Sum / SampleCount during the specified period. By
    /// comparing this statistic with the Minimum and Maximum values, you can
    /// determine the full
    /// scope of a metric and how close the average use is to the Minimum and
    /// Maximum values. This
    /// comparison helps you to know when to increase or decrease your resources.
    ///
    /// * `SampleCount` - The count, or number, of data points used for the
    /// statistical calculation.
    statistics: []const MetricStatistic,

    /// The unit for the metric data request. Valid units depend on the metric data
    /// being
    /// requested. For the valid units with each available metric, see the
    /// `metricName`
    /// parameter.
    unit: MetricUnit,

    pub const json_field_names = .{
        .end_time = "endTime",
        .metric_name = "metricName",
        .period = "period",
        .relational_database_name = "relationalDatabaseName",
        .start_time = "startTime",
        .statistics = "statistics",
        .unit = "unit",
    };
};

pub const GetRelationalDatabaseMetricDataOutput = struct {
    /// An array of objects that describe the metric data returned.
    metric_data: ?[]const MetricDatapoint = null,

    /// The name of the metric returned.
    metric_name: ?RelationalDatabaseMetricName = null,

    pub const json_field_names = .{
        .metric_data = "metricData",
        .metric_name = "metricName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRelationalDatabaseMetricDataInput, options: CallOptions) !GetRelationalDatabaseMetricDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRelationalDatabaseMetricDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.GetRelationalDatabaseMetricData");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRelationalDatabaseMetricDataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRelationalDatabaseMetricDataOutput, body, allocator);
}
