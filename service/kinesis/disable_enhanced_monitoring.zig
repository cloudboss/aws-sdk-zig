const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetricsName = @import("metrics_name.zig").MetricsName;

pub const DisableEnhancedMonitoringInput = struct {
    /// List of shard-level metrics to disable.
    ///
    /// The following are the valid shard-level metrics. The value "`ALL`" disables
    /// every metric.
    ///
    /// * `IncomingBytes`
    ///
    /// * `IncomingRecords`
    ///
    /// * `OutgoingBytes`
    ///
    /// * `OutgoingRecords`
    ///
    /// * `WriteProvisionedThroughputExceeded`
    ///
    /// * `ReadProvisionedThroughputExceeded`
    ///
    /// * `IteratorAgeMilliseconds`
    ///
    /// * `ALL`
    ///
    /// For more information, see [Monitoring the Amazon
    /// Kinesis Data Streams Service with Amazon
    /// CloudWatch](https://docs.aws.amazon.com/kinesis/latest/dev/monitoring-with-cloudwatch.html) in the *Amazon
    /// Kinesis Data Streams Developer Guide*.
    shard_level_metrics: []const MetricsName,

    /// The ARN of the stream.
    stream_arn: ?[]const u8 = null,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    /// The name of the Kinesis data stream for which to disable enhanced
    /// monitoring.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .shard_level_metrics = "ShardLevelMetrics",
        .stream_arn = "StreamARN",
        .stream_id = "StreamId",
        .stream_name = "StreamName",
    };
};

pub const DisableEnhancedMonitoringOutput = struct {
    /// Represents the current state of the metrics that are in the enhanced state
    /// before the
    /// operation.
    current_shard_level_metrics: ?[]const MetricsName = null,

    /// Represents the list of all the metrics that would be in the enhanced state
    /// after the
    /// operation.
    desired_shard_level_metrics: ?[]const MetricsName = null,

    /// The ARN of the stream.
    stream_arn: ?[]const u8 = null,

    /// The name of the Kinesis data stream.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .current_shard_level_metrics = "CurrentShardLevelMetrics",
        .desired_shard_level_metrics = "DesiredShardLevelMetrics",
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisableEnhancedMonitoringInput, options: CallOptions) !DisableEnhancedMonitoringOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesis", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DisableEnhancedMonitoringInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesis", "Kinesis", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.DisableEnhancedMonitoring");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisableEnhancedMonitoringOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DisableEnhancedMonitoringOutput, body, allocator);
}
