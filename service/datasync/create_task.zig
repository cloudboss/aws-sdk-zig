const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const FilterRule = @import("filter_rule.zig").FilterRule;
const ManifestConfig = @import("manifest_config.zig").ManifestConfig;
const Options = @import("options.zig").Options;
const TaskSchedule = @import("task_schedule.zig").TaskSchedule;
const TagListEntry = @import("tag_list_entry.zig").TagListEntry;
const TaskMode = @import("task_mode.zig").TaskMode;
const TaskReportConfig = @import("task_report_config.zig").TaskReportConfig;

pub const CreateTaskInput = struct {
    /// Specifies the Amazon Resource Name (ARN) of an Amazon CloudWatch log group
    /// for
    /// monitoring your task.
    ///
    /// For Enhanced mode tasks, you don't need to specify anything. DataSync
    /// automatically sends logs to a CloudWatch log group named
    /// `/aws/datasync`.
    cloud_watch_log_group_arn: ?[]const u8 = null,

    /// Specifies the ARN of your transfer's destination location.
    destination_location_arn: []const u8,

    /// Specifies exclude filters that define the files, objects, and folders in
    /// your source
    /// location that you don't want DataSync to transfer. For more information and
    /// examples, see [Specifying what DataSync transfers by using
    /// filters](https://docs.aws.amazon.com/datasync/latest/userguide/filtering.html).
    excludes: ?[]const FilterRule = null,

    /// Specifies include filters that define the files, objects, and folders in
    /// your source
    /// location that you want DataSync to transfer. For more information and
    /// examples, see
    /// [Specifying what
    /// DataSync transfers by using
    /// filters](https://docs.aws.amazon.com/datasync/latest/userguide/filtering.html).
    includes: ?[]const FilterRule = null,

    /// Configures a manifest, which is a list of files or objects that you want
    /// DataSync to transfer. For more information and configuration examples, see
    /// [Specifying what DataSync transfers by using a
    /// manifest](https://docs.aws.amazon.com/datasync/latest/userguide/transferring-with-manifest.html).
    ///
    /// When using this parameter, your caller identity (the role that you're using
    /// DataSync with) must have the `iam:PassRole` permission. The
    /// [AWSDataSyncFullAccess](https://docs.aws.amazon.com/datasync/latest/userguide/security-iam-awsmanpol.html#security-iam-awsmanpol-awsdatasyncfullaccess) policy includes this permission.
    manifest_config: ?ManifestConfig = null,

    /// Specifies the name of your task.
    name: ?[]const u8 = null,

    /// Specifies your task's settings, such as preserving file metadata, verifying
    /// data
    /// integrity, among other options.
    options: ?Options = null,

    /// Specifies a schedule for when you want your task to run. For more
    /// information, see [Scheduling your
    /// task](https://docs.aws.amazon.com/datasync/latest/userguide/task-scheduling.html).
    schedule: ?TaskSchedule = null,

    /// Specifies the ARN of your transfer's source location.
    source_location_arn: []const u8,

    /// Specifies the tags that you want to apply to your task.
    ///
    /// *Tags* are key-value pairs that help you manage, filter, and search
    /// for your DataSync resources.
    tags: ?[]const TagListEntry = null,

    /// Specifies one of the following task modes for your data transfer:
    ///
    /// * `ENHANCED` - Transfer virtually unlimited numbers of objects with higher
    /// performance than Basic mode. Enhanced mode tasks optimize the data transfer
    /// process by
    /// listing, preparing, transferring, and verifying data in parallel. Enhanced
    /// mode is
    /// currently available for transfers between Amazon S3 locations, transfers
    /// between
    /// Azure Blob and Amazon S3 without an agent, and transfers between other
    /// clouds and
    /// Amazon S3 without an agent.
    ///
    /// To create an Enhanced mode task, the IAM role that you use to call
    /// the `CreateTask` operation must have the
    /// `iam:CreateServiceLinkedRole` permission.
    ///
    /// * `BASIC` (default) - Transfer files or objects between Amazon Web Services
    /// storage and all other supported DataSync locations. Basic mode tasks are
    /// subject
    /// to
    /// [quotas](https://docs.aws.amazon.com/datasync/latest/userguide/datasync-limits.html) on the number of files, objects, and directories in a dataset. Basic
    /// mode sequentially prepares, transfers, and verifies data, making it slower
    /// than Enhanced
    /// mode for most workloads.
    ///
    /// For more information, see [Understanding
    /// task mode
    /// differences](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html#task-mode-differences).
    task_mode: ?TaskMode = null,

    /// Specifies how you want to configure a task report, which provides detailed
    /// information
    /// about your DataSync transfer. For more information, see [Monitoring your
    /// DataSync
    /// transfers with task
    /// reports](https://docs.aws.amazon.com/datasync/latest/userguide/task-reports.html).
    ///
    /// When using this parameter, your caller identity (the role that you're using
    /// DataSync with) must have the `iam:PassRole` permission. The
    /// [AWSDataSyncFullAccess](https://docs.aws.amazon.com/datasync/latest/userguide/security-iam-awsmanpol.html#security-iam-awsmanpol-awsdatasyncfullaccess) policy includes this permission.
    task_report_config: ?TaskReportConfig = null,

    pub const json_field_names = .{
        .cloud_watch_log_group_arn = "CloudWatchLogGroupArn",
        .destination_location_arn = "DestinationLocationArn",
        .excludes = "Excludes",
        .includes = "Includes",
        .manifest_config = "ManifestConfig",
        .name = "Name",
        .options = "Options",
        .schedule = "Schedule",
        .source_location_arn = "SourceLocationArn",
        .tags = "Tags",
        .task_mode = "TaskMode",
        .task_report_config = "TaskReportConfig",
    };
};

pub const CreateTaskOutput = struct {
    /// The Amazon Resource Name (ARN) of the task.
    task_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .task_arn = "TaskArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTaskInput, options: CallOptions) !CreateTaskOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datasync", "DataSync", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.CreateTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateTaskOutput, body, allocator);
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
