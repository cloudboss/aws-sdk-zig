const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const FilterRule = @import("filter_rule.zig").FilterRule;
const TaskExecutionFilesFailedDetail = @import("task_execution_files_failed_detail.zig").TaskExecutionFilesFailedDetail;
const TaskExecutionFilesListedDetail = @import("task_execution_files_listed_detail.zig").TaskExecutionFilesListedDetail;
const TaskExecutionFoldersFailedDetail = @import("task_execution_folders_failed_detail.zig").TaskExecutionFoldersFailedDetail;
const TaskExecutionFoldersListedDetail = @import("task_execution_folders_listed_detail.zig").TaskExecutionFoldersListedDetail;
const ManifestConfig = @import("manifest_config.zig").ManifestConfig;
const Options = @import("options.zig").Options;
const ReportResult = @import("report_result.zig").ReportResult;
const TaskExecutionResultDetail = @import("task_execution_result_detail.zig").TaskExecutionResultDetail;
const TaskExecutionStatus = @import("task_execution_status.zig").TaskExecutionStatus;
const TaskMode = @import("task_mode.zig").TaskMode;
const TaskReportConfig = @import("task_report_config.zig").TaskReportConfig;

pub const DescribeTaskExecutionInput = struct {
    /// Specifies the Amazon Resource Name (ARN) of the task execution that you want
    /// information about.
    task_execution_arn: []const u8,

    pub const json_field_names = .{
        .task_execution_arn = "TaskExecutionArn",
    };
};

pub const DescribeTaskExecutionOutput = struct {
    /// The number of physical bytes that DataSync transfers over the network after
    /// compression (if compression is possible). This number is typically less than
    /// [BytesTransferred](https://docs.aws.amazon.com/datasync/latest/userguide/API_DescribeTaskExecution.html#DataSync-DescribeTaskExecution-response-BytesTransferred) unless the data isn't compressible.
    bytes_compressed: ?i64 = null,

    /// The number of bytes that DataSync sends to the network before compression
    /// (if
    /// compression is possible). For the number of bytes transferred over the
    /// network, see
    /// [BytesCompressed](https://docs.aws.amazon.com/datasync/latest/userguide/API_DescribeTaskExecution.html#DataSync-DescribeTaskExecution-response-BytesCompressed).
    bytes_transferred: ?i64 = null,

    /// The number of logical bytes that DataSync actually writes to the destination
    /// location.
    bytes_written: ?i64 = null,

    /// The time that the transfer task ends.
    end_time: ?i64 = null,

    /// The number of logical bytes that DataSync expects to write to the
    /// destination
    /// location.
    estimated_bytes_to_transfer: ?i64 = null,

    /// The number of files, objects, and directories that DataSync expects to
    /// delete in
    /// your destination location. If you don't configure your task to [delete data
    /// in the destination that
    /// isn't in the
    /// source](https://docs.aws.amazon.com/datasync/latest/userguide/configure-metadata.html), the value is always `0`.
    ///
    /// For [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html), this counter only includes files or objects. Directories are counted in
    /// [EstimatedFoldersToDelete](https://docs.aws.amazon.com/datasync/latest/userguide/API_DescribeTaskExecution.html#DataSync-DescribeTaskExecution-response-EstimatedFoldersToDelete).
    estimated_files_to_delete: ?i64 = null,

    /// The number of files, objects, and directories that DataSync expects to
    /// transfer over the network. This value is calculated while DataSync
    /// [prepares](https://docs.aws.amazon.com/datasync/latest/userguide/run-task.html#understand-task-execution-statuses) the transfer.
    ///
    /// How this gets calculated depends primarily on your task’s [transfer
    /// mode](https://docs.aws.amazon.com/datasync/latest/userguide/API_Options.html#DataSync-Type-Options-TransferMode) configuration:
    ///
    /// * If `TranserMode` is set to `CHANGED` - The calculation is based
    /// on comparing the content of the source and destination locations and
    /// determining the
    /// difference that needs to be transferred. The difference can include:
    ///
    /// * Anything that's added or modified at the source location.
    ///
    /// * Anything that's in both locations and modified at the destination after an
    ///   initial
    /// transfer (unless
    /// [OverwriteMode](https://docs.aws.amazon.com/datasync/latest/userguide/API_Options.html#DataSync-Type-Options-OverwriteMode) is set to `NEVER`).
    ///
    /// * **(Basic task mode only)** The number of items that
    /// DataSync expects to delete (if
    /// [PreserveDeletedFiles](https://docs.aws.amazon.com/datasync/latest/userguide/API_Options.html#DataSync-Type-Options-PreserveDeletedFiles) is set to
    /// `REMOVE`).
    ///
    /// * If `TranserMode` is set to `ALL` - The calculation is based only
    /// on the items that DataSync finds at the source location.
    ///
    /// For [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html), this counter only includes files or objects. Directories are counted in
    /// [EstimatedFoldersToTransfer](https://docs.aws.amazon.com/datasync/latest/userguide/API_DescribeTaskExecution.html#DataSync-DescribeTaskExecution-response-EstimatedFoldersToTransfer).
    estimated_files_to_transfer: ?i64 = null,

    /// The number of directories that DataSync expects to delete in
    /// your destination location. If you don't configure your task to [delete data
    /// in the destination that
    /// isn't in the
    /// source](https://docs.aws.amazon.com/datasync/latest/userguide/configure-metadata.html), the value is always `0`.
    ///
    /// Applies only to [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
    estimated_folders_to_delete: ?i64 = null,

    /// The number of directories that DataSync expects to
    /// transfer over the network. This value is calculated as DataSync
    /// [prepares](https://docs.aws.amazon.com/datasync/latest/userguide/run-task.html#understand-task-execution-statuses) directories to transfer.
    ///
    /// How this gets calculated depends primarily on your task’s [transfer
    /// mode](https://docs.aws.amazon.com/datasync/latest/userguide/API_Options.html#DataSync-Type-Options-TransferMode) configuration:
    ///
    /// * If `TranserMode` is set to `CHANGED` - The calculation is based
    /// on comparing the content of the source and destination locations and
    /// determining the
    /// difference that needs to be transferred. The difference can include:
    ///
    /// * Anything that's added or modified at the source location.
    ///
    /// * Anything that's in both locations and modified at the destination after an
    ///   initial
    /// transfer (unless
    /// [OverwriteMode](https://docs.aws.amazon.com/datasync/latest/userguide/API_Options.html#DataSync-Type-Options-OverwriteMode) is set to `NEVER`).
    ///
    /// * If `TranserMode` is set to `ALL` - The calculation is based only
    /// on the items that DataSync finds at the source location.
    ///
    /// Applies only to [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
    estimated_folders_to_transfer: ?i64 = null,

    /// A list of filter rules that exclude specific data during your transfer. For
    /// more
    /// information and examples, see [Filtering data transferred by
    /// DataSync](https://docs.aws.amazon.com/datasync/latest/userguide/filtering.html).
    excludes: ?[]const FilterRule = null,

    /// The number of files, objects, and directories that DataSync actually deletes
    /// in
    /// your destination location. If you don't configure your task to [delete data
    /// in the destination that
    /// isn't in the
    /// source](https://docs.aws.amazon.com/datasync/latest/userguide/configure-metadata.html), the value is always `0`.
    ///
    /// For [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html), this counter only includes files or objects. Directories are counted in
    /// [FoldersDeleted](https://docs.aws.amazon.com/datasync/latest/userguide/API_DescribeTaskExecution.html#DataSync-DescribeTaskExecution-response-FoldersDeleted).
    files_deleted: ?i64 = null,

    /// The number of files or objects that DataSync fails to prepare, transfer,
    /// verify, and
    /// delete during your task execution.
    ///
    /// Applies only to [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
    files_failed: ?TaskExecutionFilesFailedDetail = null,

    /// The number of files or objects that DataSync finds at your locations.
    ///
    /// Applies only to [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
    files_listed: ?TaskExecutionFilesListedDetail = null,

    /// The number of files or objects that DataSync will attempt to transfer after
    /// comparing
    /// your source and destination locations.
    ///
    /// Applies only to [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
    ///
    /// This counter isn't applicable if you configure your task to [transfer
    /// all
    /// data](https://docs.aws.amazon.com/datasync/latest/userguide/configure-metadata.html#task-option-transfer-mode). In that scenario, DataSync copies everything from the source to
    /// the destination without comparing differences between the locations.
    files_prepared: ?i64 = null,

    /// The number of files, objects, and directories that DataSync skips during
    /// your
    /// transfer.
    ///
    /// For [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html), this counter only includes files or objects. Directories are counted in
    /// [FoldersSkipped](https://docs.aws.amazon.com/datasync/latest/userguide/API_DescribeTaskExecution.html#DataSync-DescribeTaskExecution-response-FoldersSkipped).
    files_skipped: ?i64 = null,

    /// The number of files, objects, and directories that DataSync actually
    /// transfers over the network. This value is updated periodically during your
    /// task execution when
    /// something is read from the source and sent over the network.
    ///
    /// If DataSync fails to transfer something, this value can be less than
    /// `EstimatedFilesToTransfer`. In some cases, this value can also be greater
    /// than
    /// `EstimatedFilesToTransfer`. This element is implementation-specific for some
    /// location types, so don't use it as an exact indication of what's
    /// transferring or to monitor
    /// your task execution.
    ///
    /// For [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html), this counter only includes files or objects. Directories are counted in
    /// [FoldersTransferred](https://docs.aws.amazon.com/datasync/latest/userguide/API_DescribeTaskExecution.html#DataSync-DescribeTaskExecution-response-FoldersTransferred).
    files_transferred: ?i64 = null,

    /// The number of files, objects, and directories that DataSync verifies during
    /// your
    /// transfer.
    ///
    /// When you configure your task to [verify only the
    /// data that's
    /// transferred](https://docs.aws.amazon.com/datasync/latest/userguide/configure-data-verification-options.html), DataSync doesn't verify directories in some
    /// situations or files that fail to transfer.
    ///
    /// For [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html), this counter only includes files or objects. Directories are counted in
    /// [FoldersVerified](https://docs.aws.amazon.com/datasync/latest/userguide/API_DescribeTaskExecution.html#DataSync-DescribeTaskExecution-response-FoldersVerified).
    files_verified: ?i64 = null,

    /// The number of directories that DataSync actually deletes in
    /// your destination location. If you don't configure your task to [delete data
    /// in the destination that
    /// isn't in the
    /// source](https://docs.aws.amazon.com/datasync/latest/userguide/configure-metadata.html), the value is always `0`.
    ///
    /// Applies only to [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
    folders_deleted: ?i64 = null,

    /// The number of directories that DataSync fails to list, prepare, transfer,
    /// verify, and
    /// delete during your task execution.
    ///
    /// Applies only to [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
    folders_failed: ?TaskExecutionFoldersFailedDetail = null,

    /// The number of directories that DataSync finds at your locations.
    ///
    /// Applies only to [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
    folders_listed: ?TaskExecutionFoldersListedDetail = null,

    /// The number of directories that DataSync will attempt to transfer after
    /// comparing
    /// your source and destination locations.
    ///
    /// Applies only to [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
    ///
    /// This counter isn't applicable if you configure your task to [transfer
    /// all
    /// data](https://docs.aws.amazon.com/datasync/latest/userguide/configure-metadata.html#task-option-transfer-mode). In that scenario, DataSync copies everything from the source to
    /// the destination without comparing differences between the locations.
    folders_prepared: ?i64 = null,

    /// The number of directories that DataSync skips during your
    /// transfer.
    ///
    /// Applies only to [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
    folders_skipped: ?i64 = null,

    /// The number of directories that DataSync actually
    /// transfers over the network. This value is updated periodically during your
    /// task execution when
    /// something is read from the source and sent over the network.
    ///
    /// If DataSync fails to transfer something, this value can be less than
    /// `EstimatedFoldersToTransfer`. In some cases, this value can also be greater
    /// than
    /// `EstimatedFoldersToTransfer`.
    ///
    /// Applies only to [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
    folders_transferred: ?i64 = null,

    /// The number of directories that DataSync verifies during your transfer.
    ///
    /// Applies only to [Enhanced mode
    /// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
    folders_verified: ?i64 = null,

    /// A list of filter rules that include specific data during your transfer. For
    /// more
    /// information and examples, see [Filtering data transferred by
    /// DataSync](https://docs.aws.amazon.com/datasync/latest/userguide/filtering.html).
    includes: ?[]const FilterRule = null,

    /// The time that the task execution actually begins. For non-queued tasks,
    /// `LaunchTime` and `StartTime` are typically the same. For queued tasks,
    /// `LaunchTime` is typically later than `StartTime` because previously
    /// queued tasks must finish running before newer tasks can begin.
    launch_time: ?i64 = null,

    /// The configuration of the manifest that lists the files or objects to
    /// transfer. For more
    /// information, see [Specifying what DataSync transfers by using a
    /// manifest](https://docs.aws.amazon.com/datasync/latest/userguide/transferring-with-manifest.html).
    manifest_config: ?ManifestConfig = null,

    options: ?Options = null,

    /// Indicates whether DataSync generated a complete [task
    /// report](https://docs.aws.amazon.com/datasync/latest/userguide/task-reports.html) for your
    /// transfer.
    report_result: ?ReportResult = null,

    /// The result of the task execution.
    result: ?TaskExecutionResultDetail = null,

    /// The time that DataSync sends the request to start the task execution. For
    /// non-queued tasks, `LaunchTime` and `StartTime` are typically the same.
    /// For queued tasks, `LaunchTime` is typically later than `StartTime`
    /// because previously queued tasks must finish running before newer tasks can
    /// begin.
    start_time: ?i64 = null,

    /// The status of the task execution.
    status: ?TaskExecutionStatus = null,

    /// The ARN of the task execution that you wanted information about.
    /// `TaskExecutionArn` is hierarchical and includes `TaskArn` for the task
    /// that was executed.
    ///
    /// For example, a `TaskExecution` value with the ARN
    /// `arn:aws:datasync:us-east-1:111222333444:task/task-0208075f79cedf4a2/execution/exec-08ef1e88ec491019b`
    /// executed the task with the ARN
    /// `arn:aws:datasync:us-east-1:111222333444:task/task-0208075f79cedf4a2`.
    task_execution_arn: ?[]const u8 = null,

    /// The task mode that you're using. For more information, see [Choosing a task
    /// mode for your data
    /// transfer](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
    task_mode: ?TaskMode = null,

    /// The configuration of your task report, which provides detailed information
    /// about for your
    /// DataSync transfer. For more information, see [Creating a task
    /// report](https://docs.aws.amazon.com/datasync/latest/userguide/task-reports.html).
    task_report_config: ?TaskReportConfig = null,

    pub const json_field_names = .{
        .bytes_compressed = "BytesCompressed",
        .bytes_transferred = "BytesTransferred",
        .bytes_written = "BytesWritten",
        .end_time = "EndTime",
        .estimated_bytes_to_transfer = "EstimatedBytesToTransfer",
        .estimated_files_to_delete = "EstimatedFilesToDelete",
        .estimated_files_to_transfer = "EstimatedFilesToTransfer",
        .estimated_folders_to_delete = "EstimatedFoldersToDelete",
        .estimated_folders_to_transfer = "EstimatedFoldersToTransfer",
        .excludes = "Excludes",
        .files_deleted = "FilesDeleted",
        .files_failed = "FilesFailed",
        .files_listed = "FilesListed",
        .files_prepared = "FilesPrepared",
        .files_skipped = "FilesSkipped",
        .files_transferred = "FilesTransferred",
        .files_verified = "FilesVerified",
        .folders_deleted = "FoldersDeleted",
        .folders_failed = "FoldersFailed",
        .folders_listed = "FoldersListed",
        .folders_prepared = "FoldersPrepared",
        .folders_skipped = "FoldersSkipped",
        .folders_transferred = "FoldersTransferred",
        .folders_verified = "FoldersVerified",
        .includes = "Includes",
        .launch_time = "LaunchTime",
        .manifest_config = "ManifestConfig",
        .options = "Options",
        .report_result = "ReportResult",
        .result = "Result",
        .start_time = "StartTime",
        .status = "Status",
        .task_execution_arn = "TaskExecutionArn",
        .task_mode = "TaskMode",
        .task_report_config = "TaskReportConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTaskExecutionInput, options: CallOptions) !DescribeTaskExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTaskExecutionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.DescribeTaskExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTaskExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeTaskExecutionOutput, body, allocator);
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
