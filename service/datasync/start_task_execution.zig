const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const FilterRule = @import("filter_rule.zig").FilterRule;
const ManifestConfig = @import("manifest_config.zig").ManifestConfig;
const Options = @import("options.zig").Options;
const TagListEntry = @import("tag_list_entry.zig").TagListEntry;
const TaskReportConfig = @import("task_report_config.zig").TaskReportConfig;

pub const StartTaskExecutionInput = struct {
    /// Specifies a list of filter rules that determines which files to exclude from
    /// a task. The
    /// list contains a single filter string that consists of the patterns to
    /// exclude. The patterns
    /// are delimited by "|" (that is, a pipe), for example, `"/folder1|/folder2"`.
    excludes: ?[]const FilterRule = null,

    /// Specifies a list of filter rules that determines which files to include when
    /// running a
    /// task. The pattern should contain a single filter string that consists of the
    /// patterns to
    /// include. The patterns are delimited by "|" (that is, a pipe), for example,
    /// `"/folder1|/folder2"`.
    includes: ?[]const FilterRule = null,

    /// Configures a manifest, which is a list of files or objects that you want
    /// DataSync to transfer. For more information and configuration examples, see
    /// [Specifying what DataSync transfers by using a
    /// manifest](https://docs.aws.amazon.com/datasync/latest/userguide/transferring-with-manifest.html).
    ///
    /// When using this parameter, your caller identity (the role that you're using
    /// DataSync with) must have the `iam:PassRole` permission. The
    /// [AWSDataSyncFullAccess](https://docs.aws.amazon.com/datasync/latest/userguide/security-iam-awsmanpol.html#security-iam-awsmanpol-awsdatasyncfullaccess) policy includes this permission.
    ///
    /// To remove a manifest configuration, specify this parameter with an empty
    /// value.
    manifest_config: ?ManifestConfig = null,

    override_options: ?Options = null,

    /// Specifies the tags that you want to apply to the Amazon Resource Name (ARN)
    /// representing
    /// the task execution.
    ///
    /// *Tags* are key-value pairs that help you manage, filter, and search for
    /// your DataSync resources.
    tags: ?[]const TagListEntry = null,

    /// Specifies the Amazon Resource Name (ARN) of the task that you want to start.
    task_arn: []const u8,

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
    ///
    /// To remove a task report configuration, specify this parameter as empty.
    task_report_config: ?TaskReportConfig = null,

    pub const json_field_names = .{
        .excludes = "Excludes",
        .includes = "Includes",
        .manifest_config = "ManifestConfig",
        .override_options = "OverrideOptions",
        .tags = "Tags",
        .task_arn = "TaskArn",
        .task_report_config = "TaskReportConfig",
    };
};

pub const StartTaskExecutionOutput = struct {
    /// The ARN of the running task execution.
    task_execution_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .task_execution_arn = "TaskExecutionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartTaskExecutionInput, options: CallOptions) !StartTaskExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartTaskExecutionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.StartTaskExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartTaskExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartTaskExecutionOutput, body, allocator);
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
