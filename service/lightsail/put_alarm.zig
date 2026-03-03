const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;
const ContactProtocol = @import("contact_protocol.zig").ContactProtocol;
const MetricName = @import("metric_name.zig").MetricName;
const AlarmState = @import("alarm_state.zig").AlarmState;
const TreatMissingData = @import("treat_missing_data.zig").TreatMissingData;
const Operation = @import("operation.zig").Operation;

pub const PutAlarmInput = struct {
    /// The name for the alarm. Specify the name of an existing alarm to update, and
    /// overwrite the
    /// previous configuration of the alarm.
    alarm_name: []const u8,

    /// The arithmetic operation to use when comparing the specified statistic to
    /// the threshold.
    /// The specified statistic value is used as the first operand.
    comparison_operator: ComparisonOperator,

    /// The contact protocols to use for the alarm, such as `Email`, `SMS`
    /// (text messaging), or both.
    ///
    /// A notification is sent via the specified contact protocol if notifications
    /// are enabled for
    /// the alarm, and when the alarm is triggered.
    ///
    /// A notification is not sent if a contact protocol is not specified, if the
    /// specified
    /// contact protocol is not configured in the Amazon Web Services Region, or if
    /// notifications are
    /// not enabled for the alarm using the `notificationEnabled` paramater.
    ///
    /// Use the `CreateContactMethod` action to configure a contact protocol in an
    /// Amazon Web Services Region.
    contact_protocols: ?[]const ContactProtocol = null,

    /// The number of data points that must be not within the specified threshold to
    /// trigger the
    /// alarm. If you are setting an "M out of N" alarm, this value
    /// (`datapointsToAlarm`)
    /// is the M.
    datapoints_to_alarm: ?i32 = null,

    /// The number of most recent periods over which data is compared to the
    /// specified threshold.
    /// If you are setting an "M out of N" alarm, this value (`evaluationPeriods`)
    /// is the
    /// N.
    ///
    /// If you are setting an alarm that requires that a number of consecutive data
    /// points be
    /// breaching to trigger the alarm, this value specifies the rolling period of
    /// time in which data
    /// points are evaluated.
    ///
    /// Each evaluation period is five minutes long. For example, specify an
    /// evaluation period of
    /// 24 to evaluate a metric over a rolling period of two hours.
    ///
    /// You can specify a minimum valuation period of 1 (5 minutes), and a maximum
    /// evaluation
    /// period of 288 (24 hours).
    evaluation_periods: i32,

    /// The name of the metric to associate with the alarm.
    ///
    /// You can configure up to two alarms per metric.
    ///
    /// The following metrics are available for each resource type:
    ///
    /// * **Instances**: `BurstCapacityPercentage`,
    /// `BurstCapacityTime`, `CPUUtilization`, `NetworkIn`,
    /// `NetworkOut`, `StatusCheckFailed`,
    /// `StatusCheckFailed_Instance`, and
    /// `StatusCheckFailed_System`.
    ///
    /// * **Load balancers**:
    /// `ClientTLSNegotiationErrorCount`, `HealthyHostCount`,
    /// `UnhealthyHostCount`, `HTTPCode_LB_4XX_Count`,
    /// `HTTPCode_LB_5XX_Count`, `HTTPCode_Instance_2XX_Count`,
    /// `HTTPCode_Instance_3XX_Count`, `HTTPCode_Instance_4XX_Count`,
    /// `HTTPCode_Instance_5XX_Count`, `InstanceResponseTime`,
    /// `RejectedConnectionCount`, and `RequestCount`.
    ///
    /// * **Relational databases**: `CPUUtilization`,
    /// `DatabaseConnections`, `DiskQueueDepth`,
    /// `FreeStorageSpace`, `NetworkReceiveThroughput`, and
    /// `NetworkTransmitThroughput`.
    ///
    /// For more information about these metrics, see [Metrics available in
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-resource-health-metrics#available-metrics).
    metric_name: MetricName,

    /// The name of the Lightsail resource that will be monitored.
    ///
    /// Instances, load balancers, and relational databases are the only Lightsail
    /// resources
    /// that can currently be monitored by alarms.
    monitored_resource_name: []const u8,

    /// Indicates whether the alarm is enabled.
    ///
    /// Notifications are enabled by default if you don't specify this parameter.
    notification_enabled: ?bool = null,

    /// The alarm states that trigger a notification.
    ///
    /// An alarm has the following possible states:
    ///
    /// * `ALARM` - The metric is outside of the defined threshold.
    ///
    /// * `INSUFFICIENT_DATA` - The alarm has just started, the metric is not
    /// available, or not enough data is available for the metric to determine the
    /// alarm
    /// state.
    ///
    /// * `OK` - The metric is within the defined threshold.
    ///
    /// When you specify a notification trigger, the `ALARM` state must be
    /// specified.
    /// The `INSUFFICIENT_DATA` and `OK` states can be specified in addition to
    /// the `ALARM` state.
    ///
    /// * If you specify `OK` as an alarm trigger, a notification is sent when the
    /// alarm switches from an `ALARM` or `INSUFFICIENT_DATA` alarm state to
    /// an `OK` state. This can be thought of as an *all clear*
    /// alarm notification.
    ///
    /// * If you specify `INSUFFICIENT_DATA` as the alarm trigger, a notification is
    /// sent when the alarm switches from an `OK` or `ALARM` alarm state to
    /// an `INSUFFICIENT_DATA` state.
    ///
    /// The notification trigger defaults to `ALARM` if you don't specify this
    /// parameter.
    notification_triggers: ?[]const AlarmState = null,

    /// The value against which the specified statistic is compared.
    threshold: f64,

    /// Sets how this alarm will handle missing data points.
    ///
    /// An alarm can treat missing data in the following ways:
    ///
    /// * `breaching` - Assume the missing data is not within the threshold. Missing
    /// data counts towards the number of times the metric is not within the
    /// threshold.
    ///
    /// * `notBreaching` - Assume the missing data is within the threshold. Missing
    /// data does not count towards the number of times the metric is not within the
    /// threshold.
    ///
    /// * `ignore` - Ignore the missing data. Maintains the current alarm
    /// state.
    ///
    /// * `missing` - Missing data is treated as missing.
    ///
    /// If `treatMissingData` is not specified, the default behavior of
    /// `missing` is used.
    treat_missing_data: ?TreatMissingData = null,

    pub const json_field_names = .{
        .alarm_name = "alarmName",
        .comparison_operator = "comparisonOperator",
        .contact_protocols = "contactProtocols",
        .datapoints_to_alarm = "datapointsToAlarm",
        .evaluation_periods = "evaluationPeriods",
        .metric_name = "metricName",
        .monitored_resource_name = "monitoredResourceName",
        .notification_enabled = "notificationEnabled",
        .notification_triggers = "notificationTriggers",
        .threshold = "threshold",
        .treat_missing_data = "treatMissingData",
    };
};

pub const PutAlarmOutput = struct {
    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .operations = "operations",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAlarmInput, options: Options) !PutAlarmOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: PutAlarmInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.PutAlarm");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAlarmOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutAlarmOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
