const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InstanceMetricName = @import("instance_metric_name.zig").InstanceMetricName;
const MetricStatistic = @import("metric_statistic.zig").MetricStatistic;
const MetricUnit = @import("metric_unit.zig").MetricUnit;
const MetricDatapoint = @import("metric_datapoint.zig").MetricDatapoint;

pub const GetInstanceMetricDataInput = struct {
    /// The end time of the time period.
    end_time: i64,

    /// The name of the instance for which you want to get metrics data.
    instance_name: []const u8,

    /// The metric for which you want to return information.
    ///
    /// Valid instance metric names are listed below, along with the most useful
    /// `statistics` to include in your request, and the published `unit`
    /// value.
    ///
    /// * **
    /// `BurstCapacityPercentage`
    /// ** - The percentage
    /// of CPU performance available for your instance to burst above its baseline.
    /// Your instance
    /// continuously accrues and consumes burst capacity. Burst capacity stops
    /// accruing when your
    /// instance's `BurstCapacityPercentage` reaches 100%. For more information, see
    /// [Viewing instance burst capacity in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-viewing-instance-burst-capacity).
    ///
    /// `Statistics`: The most useful statistics are `Maximum` and
    /// `Average`.
    ///
    /// `Unit`: The published unit is `Percent`.
    ///
    /// * **
    /// `BurstCapacityTime`
    /// ** - The available amount
    /// of time for your instance to burst at 100% CPU utilization. Your instance
    /// continuously
    /// accrues and consumes burst capacity. Burst capacity time stops accruing when
    /// your
    /// instance's `BurstCapacityPercentage` metric reaches 100%.
    ///
    /// Burst capacity time is consumed at the full rate only when your instance
    /// operates at
    /// 100% CPU utilization. For example, if your instance operates at 50% CPU
    /// utilization in the
    /// burstable zone for a 5-minute period, then it consumes CPU burst capacity
    /// minutes at a 50%
    /// rate in that period. Your instance consumed 2 minutes and 30 seconds of CPU
    /// burst capacity
    /// minutes in the 5-minute period. For more information, see [Viewing instance
    /// burst capacity in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-viewing-instance-burst-capacity).
    ///
    /// `Statistics`: The most useful statistics are `Maximum` and
    /// `Average`.
    ///
    /// `Unit`: The published unit is `Seconds`.
    ///
    /// * **
    /// `CPUUtilization`
    /// ** - The percentage of
    /// allocated compute units that are currently in use on the instance. This
    /// metric identifies
    /// the processing power to run the applications on the instance. Tools in your
    /// operating
    /// system can show a lower percentage than Lightsail when the instance is not
    /// allocated a
    /// full processor core.
    ///
    /// `Statistics`: The most useful statistics are `Maximum` and
    /// `Average`.
    ///
    /// `Unit`: The published unit is `Percent`.
    ///
    /// * **
    /// `NetworkIn`
    /// ** - The number of bytes received
    /// on all network interfaces by the instance. This metric identifies the volume
    /// of incoming
    /// network traffic to the instance. The number reported is the number of bytes
    /// received
    /// during the period. Because this metric is reported in 5-minute intervals,
    /// divide the
    /// reported number by 300 to find Bytes/second.
    ///
    /// `Statistics`: The most useful statistic is `Sum`.
    ///
    /// `Unit`: The published unit is `Bytes`.
    ///
    /// * **
    /// `NetworkOut`
    /// ** - The number of bytes sent
    /// out on all network interfaces by the instance. This metric identifies the
    /// volume of
    /// outgoing network traffic from the instance. The number reported is the
    /// number of bytes
    /// sent during the period. Because this metric is reported in 5-minute
    /// intervals, divide the
    /// reported number by 300 to find Bytes/second.
    ///
    /// `Statistics`: The most useful statistic is `Sum`.
    ///
    /// `Unit`: The published unit is `Bytes`.
    ///
    /// * **
    /// `StatusCheckFailed`
    /// ** - Reports whether the
    /// instance passed or failed both the instance status check and the system
    /// status check. This
    /// metric can be either 0 (passed) or 1 (failed). This metric data is available
    /// in 1-minute
    /// (60 seconds) granularity.
    ///
    /// `Statistics`: The most useful statistic is `Sum`.
    ///
    /// `Unit`: The published unit is `Count`.
    ///
    /// * **
    /// `StatusCheckFailed_Instance`
    /// ** - Reports
    /// whether the instance passed or failed the instance status check. This metric
    /// can be either
    /// 0 (passed) or 1 (failed). This metric data is available in 1-minute (60
    /// seconds)
    /// granularity.
    ///
    /// `Statistics`: The most useful statistic is `Sum`.
    ///
    /// `Unit`: The published unit is `Count`.
    ///
    /// * **
    /// `StatusCheckFailed_System`
    /// ** - Reports
    /// whether the instance passed or failed the system status check. This metric
    /// can be either 0
    /// (passed) or 1 (failed). This metric data is available in 1-minute (60
    /// seconds)
    /// granularity.
    ///
    /// `Statistics`: The most useful statistic is `Sum`.
    ///
    /// `Unit`: The published unit is `Count`.
    ///
    /// * **
    /// `MetadataNoToken`
    /// ** - Reports the number of
    /// times that the instance metadata service was successfully accessed without a
    /// token. This
    /// metric determines if there are any processes accessing instance metadata by
    /// using Instance
    /// Metadata Service Version 1, which doesn't use a token. If all requests use
    /// token-backed
    /// sessions, such as Instance Metadata Service Version 2, then the value is 0.
    ///
    /// `Statistics`: The most useful statistic is `Sum`.
    ///
    /// `Unit`: The published unit is `Count`.
    metric_name: InstanceMetricName,

    /// The granularity, in seconds, of the returned data points.
    ///
    /// The `StatusCheckFailed`, `StatusCheckFailed_Instance`, and
    /// `StatusCheckFailed_System` instance metric data is available in 1-minute (60
    /// seconds) granularity. All other instance metric data is available in
    /// 5-minute (300 seconds)
    /// granularity.
    period: i32,

    /// The start time of the time period.
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
    /// requested. For the valid units to specify with each available metric, see
    /// the
    /// `metricName` parameter.
    unit: MetricUnit,

    pub const json_field_names = .{
        .end_time = "endTime",
        .instance_name = "instanceName",
        .metric_name = "metricName",
        .period = "period",
        .start_time = "startTime",
        .statistics = "statistics",
        .unit = "unit",
    };
};

pub const GetInstanceMetricDataOutput = struct {
    /// An array of objects that describe the metric data returned.
    metric_data: ?[]const MetricDatapoint = null,

    /// The name of the metric returned.
    metric_name: ?InstanceMetricName = null,

    pub const json_field_names = .{
        .metric_data = "metricData",
        .metric_name = "metricName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInstanceMetricDataInput, options: Options) !GetInstanceMetricDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lightsail");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetInstanceMetricDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "Lightsail_20161128.GetInstanceMetricData");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetInstanceMetricDataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetInstanceMetricDataOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountSetupInProgressException")) {
        return .{ .arena = arena, .kind = .{ .account_setup_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationFailureException")) {
        return .{ .arena = arena, .kind = .{ .operation_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RegionSetupInProgressException")) {
        return .{ .arena = arena, .kind = .{ .region_setup_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthenticatedException")) {
        return .{ .arena = arena, .kind = .{ .unauthenticated_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
