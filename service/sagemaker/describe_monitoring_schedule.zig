const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const MonitoringExecutionSummary = @import("monitoring_execution_summary.zig").MonitoringExecutionSummary;
const MonitoringScheduleConfig = @import("monitoring_schedule_config.zig").MonitoringScheduleConfig;
const ScheduleStatus = @import("schedule_status.zig").ScheduleStatus;
const MonitoringType = @import("monitoring_type.zig").MonitoringType;

pub const DescribeMonitoringScheduleInput = struct {
    /// Name of a previously created monitoring schedule.
    monitoring_schedule_name: []const u8,

    pub const json_field_names = .{
        .monitoring_schedule_name = "MonitoringScheduleName",
    };
};

pub const DescribeMonitoringScheduleOutput = struct {
    /// The time at which the monitoring job was created.
    creation_time: i64,

    /// The name of the endpoint for the monitoring job.
    endpoint_name: ?[]const u8 = null,

    /// A string, up to one KB in size, that contains the reason a monitoring job
    /// failed, if it failed.
    failure_reason: ?[]const u8 = null,

    /// The time at which the monitoring job was last modified.
    last_modified_time: i64,

    /// Describes metadata on the last execution to run, if there was one.
    last_monitoring_execution_summary: ?MonitoringExecutionSummary = null,

    /// The Amazon Resource Name (ARN) of the monitoring schedule.
    monitoring_schedule_arn: []const u8,

    /// The configuration object that specifies the monitoring schedule and defines
    /// the monitoring job.
    monitoring_schedule_config: ?MonitoringScheduleConfig = null,

    /// Name of the monitoring schedule.
    monitoring_schedule_name: []const u8,

    /// The status of an monitoring job.
    monitoring_schedule_status: ScheduleStatus,

    /// The type of the monitoring job that this schedule runs. This is one of the
    /// following values.
    ///
    /// * `DATA_QUALITY` - The schedule is for a data quality monitoring job.
    /// * `MODEL_QUALITY` - The schedule is for a model quality monitoring job.
    /// * `MODEL_BIAS` - The schedule is for a bias monitoring job.
    /// * `MODEL_EXPLAINABILITY` - The schedule is for an explainability monitoring
    ///   job.
    monitoring_type: ?MonitoringType = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .endpoint_name = "EndpointName",
        .failure_reason = "FailureReason",
        .last_modified_time = "LastModifiedTime",
        .last_monitoring_execution_summary = "LastMonitoringExecutionSummary",
        .monitoring_schedule_arn = "MonitoringScheduleArn",
        .monitoring_schedule_config = "MonitoringScheduleConfig",
        .monitoring_schedule_name = "MonitoringScheduleName",
        .monitoring_schedule_status = "MonitoringScheduleStatus",
        .monitoring_type = "MonitoringType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMonitoringScheduleInput, options: CallOptions) !DescribeMonitoringScheduleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMonitoringScheduleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeMonitoringSchedule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMonitoringScheduleOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeMonitoringScheduleOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
