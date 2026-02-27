const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FilterRule = @import("filter_rule.zig").FilterRule;
const ManifestConfig = @import("manifest_config.zig").ManifestConfig;
const TaskSchedule = @import("task_schedule.zig").TaskSchedule;
const TaskScheduleDetails = @import("task_schedule_details.zig").TaskScheduleDetails;
const TaskStatus = @import("task_status.zig").TaskStatus;
const TaskMode = @import("task_mode.zig").TaskMode;
const TaskReportConfig = @import("task_report_config.zig").TaskReportConfig;

pub const DescribeTaskInput = struct {
    /// Specifies the Amazon Resource Name (ARN) of the transfer task that you want
    /// information
    /// about.
    task_arn: []const u8,

    pub const json_field_names = .{
        .task_arn = "TaskArn",
    };
};

pub const DescribeTaskOutput = struct {
    /// The Amazon Resource Name (ARN) of an Amazon CloudWatch log group for
    /// monitoring your
    /// task.
    ///
    /// For more information, see [Monitoring data transfers with
    /// CloudWatch
    /// Logs](https://docs.aws.amazon.com/datasync/latest/userguide/configure-logging.html).
    cloud_watch_log_group_arn: ?[]const u8 = null,

    /// The time that the task was created.
    creation_time: ?i64 = null,

    /// The ARN of the most recent task execution.
    current_task_execution_arn: ?[]const u8 = null,

    /// The ARN of your transfer's destination location.
    destination_location_arn: ?[]const u8 = null,

    /// The ARNs of the [network
    /// interfaces](https://docs.aws.amazon.com/datasync/latest/userguide/datasync-network.html#required-network-interfaces) that DataSync created for your destination location.
    destination_network_interface_arns: ?[]const []const u8 = null,

    /// If there's an issue with your task, you can use the error code to help you
    /// troubleshoot
    /// the problem. For more information, see [Troubleshooting issues with DataSync
    /// transfers](https://docs.aws.amazon.com/datasync/latest/userguide/troubleshooting-datasync-locations-tasks.html).
    error_code: ?[]const u8 = null,

    /// If there's an issue with your task, you can use the error details to help
    /// you
    /// troubleshoot the problem. For more information, see [Troubleshooting issues
    /// with DataSync
    /// transfers](https://docs.aws.amazon.com/datasync/latest/userguide/troubleshooting-datasync-locations-tasks.html).
    error_detail: ?[]const u8 = null,

    /// The exclude filters that define the files, objects, and folders in your
    /// source location
    /// that you don't want DataSync to transfer. For more information and examples,
    /// see
    /// [Specifying what
    /// DataSync transfers by using
    /// filters](https://docs.aws.amazon.com/datasync/latest/userguide/filtering.html).
    excludes: ?[]const FilterRule = null,

    /// The include filters that define the files, objects, and folders in your
    /// source location
    /// that you want DataSync to transfer. For more information and examples, see
    /// [Specifying what DataSync transfers by using
    /// filters](https://docs.aws.amazon.com/datasync/latest/userguide/filtering.html).
    includes: ?[]const FilterRule = null,

    /// The configuration of the manifest that lists the files or objects that you
    /// want DataSync to transfer. For more information, see [Specifying what
    /// DataSync transfers by using a
    /// manifest](https://docs.aws.amazon.com/datasync/latest/userguide/transferring-with-manifest.html).
    manifest_config: ?ManifestConfig = null,

    /// The name of your task.
    name: ?[]const u8 = null,

    /// The task's settings. For example, what file metadata gets preserved, how
    /// data integrity
    /// gets verified at the end of your transfer, bandwidth limits, among other
    /// options.
    options: ?Options = null,

    /// The schedule for when you want your task to run. For more information, see
    /// [Scheduling your
    /// task](https://docs.aws.amazon.com/datasync/latest/userguide/task-scheduling.html).
    schedule: ?TaskSchedule = null,

    /// The details about your [task
    /// schedule](https://docs.aws.amazon.com/datasync/latest/userguide/task-scheduling.html).
    schedule_details: ?TaskScheduleDetails = null,

    /// The ARN of your transfer's source location.
    source_location_arn: ?[]const u8 = null,

    /// The ARNs of the [network
    /// interfaces](https://docs.aws.amazon.com/datasync/latest/userguide/datasync-network.html#required-network-interfaces) that DataSync created for your source location.
    source_network_interface_arns: ?[]const []const u8 = null,

    /// The status of your task. For information about what each status means, see
    /// [Task
    /// statuses](https://docs.aws.amazon.com/datasync/latest/userguide/create-task-how-to.html#understand-task-creation-statuses).
    status: ?TaskStatus = null,

    /// The ARN of your task.
    task_arn: ?[]const u8 = null,

    /// The task mode that you're using. For more information, see [Choosing a task
    /// mode for your data
    /// transfer](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
    task_mode: ?TaskMode = null,

    /// The configuration of your task report, which provides detailed information
    /// about your
    /// DataSync transfer. For more information, see [Monitoring your DataSync
    /// transfers with task
    /// reports](https://docs.aws.amazon.com/datasync/latest/userguide/task-reports.html).
    task_report_config: ?TaskReportConfig = null,

    pub const json_field_names = .{
        .cloud_watch_log_group_arn = "CloudWatchLogGroupArn",
        .creation_time = "CreationTime",
        .current_task_execution_arn = "CurrentTaskExecutionArn",
        .destination_location_arn = "DestinationLocationArn",
        .destination_network_interface_arns = "DestinationNetworkInterfaceArns",
        .error_code = "ErrorCode",
        .error_detail = "ErrorDetail",
        .excludes = "Excludes",
        .includes = "Includes",
        .manifest_config = "ManifestConfig",
        .name = "Name",
        .options = "Options",
        .schedule = "Schedule",
        .schedule_details = "ScheduleDetails",
        .source_location_arn = "SourceLocationArn",
        .source_network_interface_arns = "SourceNetworkInterfaceArns",
        .status = "Status",
        .task_arn = "TaskArn",
        .task_mode = "TaskMode",
        .task_report_config = "TaskReportConfig",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTaskInput, options: Options) !DescribeTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datasync");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datasync", "DataSync", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "FmrsService.DescribeTask");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeTaskOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
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
