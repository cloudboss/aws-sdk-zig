const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CacheBehavior = @import("cache_behavior.zig").CacheBehavior;
const RunLogLevel = @import("run_log_level.zig").RunLogLevel;
const RunRetentionMode = @import("run_retention_mode.zig").RunRetentionMode;
const StorageType = @import("storage_type.zig").StorageType;
const WorkflowType = @import("workflow_type.zig").WorkflowType;
const RunStatus = @import("run_status.zig").RunStatus;

pub const StartRunInput = struct {
    /// The cache behavior for the run. You specify this value if you want to
    /// override the default behavior for the cache. You had set the default value
    /// when you created the cache. For more information, see [Run cache
    /// behavior](https://docs.aws.amazon.com/omics/latest/dev/how-run-cache.html#run-cache-behavior) in the *Amazon Web Services HealthOmics User Guide*.
    cache_behavior: ?CacheBehavior = null,

    /// Identifier of the cache associated with this run. If you don't specify a
    /// cache ID, no task outputs are cached for this run.
    cache_id: ?[]const u8 = null,

    /// A log level for the run.
    log_level: ?RunLogLevel = null,

    /// A name for the run. This is recommended to view and organize runs in the
    /// Amazon Web Services HealthOmics console and CloudWatch logs.
    name: ?[]const u8 = null,

    /// An output S3 URI for the run. The S3 bucket must be in the same region as
    /// the workflow. The role ARN must have permission to write to this S3 bucket.
    output_uri: []const u8,

    /// Parameters for the run. The run needs all required parameters and can
    /// include optional parameters. The run cannot include any parameters that are
    /// not defined in the parameter template. To retrieve parameters from the run,
    /// use the GetRun API operation.
    parameters: ?[]const u8 = null,

    /// Use the run priority (highest: 1) to establish the order of runs in a run
    /// group when you start a run. If multiple runs share the same priority, the
    /// run that was initiated first will have the higher priority. Runs that do not
    /// belong to a run group can be assigned a priority. The priorities of these
    /// runs are ranked among other runs that are not in a run group. For more
    /// information, see [Run
    /// priority](https://docs.aws.amazon.com/omics/latest/dev/creating-run-groups.html#run-priority) in the *Amazon Web Services HealthOmics User Guide*.
    priority: ?i32 = null,

    /// An idempotency token used to dedupe retry requests so that duplicate runs
    /// are not created.
    request_id: []const u8,

    /// The retention mode for the run. The default value is `RETAIN`.
    ///
    /// Amazon Web Services HealthOmics stores a fixed number of runs that are
    /// available to the console and API. In the default mode (`RETAIN`), you need
    /// to remove runs manually when the number of run exceeds the maximum. If you
    /// set the retention mode to `REMOVE`, Amazon Web Services HealthOmics
    /// automatically removes runs (that have mode set to `REMOVE`) when the number
    /// of run exceeds the maximum. All run logs are available in CloudWatch logs,
    /// if you need information about a run that is no longer available to the API.
    ///
    /// For more information about retention mode, see [Specifying run retention
    /// mode](https://docs.aws.amazon.com/omics/latest/dev/starting-a-run.html) in
    /// the *Amazon Web Services HealthOmics User Guide*.
    retention_mode: ?RunRetentionMode = null,

    /// A service role for the run. The `roleArn` requires access to Amazon Web
    /// Services HealthOmics, S3, Cloudwatch logs, and EC2. An example `roleArn` is
    /// `arn:aws:iam::123456789012:role/omics-service-role-serviceRole-W8O1XMPL7QZ`.
    /// In this example, the AWS account ID is `123456789012` and the role name is
    /// `omics-service-role-serviceRole-W8O1XMPL7QZ`.
    role_arn: []const u8,

    /// The run's group ID. Use a run group to cap the compute resources (and number
    /// of concurrent runs) for the runs that you add to the run group.
    run_group_id: ?[]const u8 = null,

    /// The ID of a run to duplicate.
    run_id: ?[]const u8 = null,

    /// The `STATIC` storage capacity (in gibibytes, GiB) for this run. The default
    /// run storage capacity is 1200 GiB. If your requested storage capacity is
    /// unavailable, the system rounds up the value to the nearest 1200 GiB
    /// multiple. If the requested storage capacity is still unavailable, the system
    /// rounds up the value to the nearest 2400 GiB multiple. This field is not
    /// required if the storage type is `DYNAMIC` (the system ignores any value that
    /// you enter).
    storage_capacity: ?i32 = null,

    /// The storage type for the run. If you set the storage type to `DYNAMIC`,
    /// Amazon Web Services HealthOmics dynamically scales the storage up or down,
    /// based on file system utilization. By default, the run uses `STATIC` storage
    /// type, which allocates a fixed amount of storage. For more information about
    /// `DYNAMIC` and `STATIC` storage, see [Run storage
    /// types](https://docs.aws.amazon.com/omics/latest/dev/workflows-run-types.html) in the *Amazon Web Services HealthOmics User Guide*.
    storage_type: ?StorageType = null,

    /// Tags for the run. You can add up to 50 tags per run. For more information,
    /// see [Adding a
    /// tag](https://docs.aws.amazon.com/omics/latest/dev/add-a-tag.html) in the
    /// *Amazon Web Services HealthOmics User Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The run's workflow ID. The `workflowId` is not the UUID.
    workflow_id: ?[]const u8 = null,

    /// The 12-digit account ID of the workflow owner that is used for running a
    /// shared workflow. The workflow owner ID can be retrieved using the `GetShare`
    /// API operation. If you are the workflow owner, you do not need to include
    /// this ID.
    workflow_owner_id: ?[]const u8 = null,

    /// The run's workflow type. The `workflowType` must be specified if you are
    /// running a `READY2RUN` workflow. If you are running a `PRIVATE` workflow
    /// (default), you do not need to include the workflow type.
    workflow_type: ?WorkflowType = null,

    /// The name of the workflow version. Use workflow versions to track and
    /// organize changes to the workflow. If your workflow has multiple versions,
    /// the run uses the default version unless you specify a version name. To learn
    /// more, see [Workflow
    /// versioning](https://docs.aws.amazon.com/omics/latest/dev/workflow-versions.html) in the *Amazon Web Services HealthOmics User Guide*.
    workflow_version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .cache_behavior = "cacheBehavior",
        .cache_id = "cacheId",
        .log_level = "logLevel",
        .name = "name",
        .output_uri = "outputUri",
        .parameters = "parameters",
        .priority = "priority",
        .request_id = "requestId",
        .retention_mode = "retentionMode",
        .role_arn = "roleArn",
        .run_group_id = "runGroupId",
        .run_id = "runId",
        .storage_capacity = "storageCapacity",
        .storage_type = "storageType",
        .tags = "tags",
        .workflow_id = "workflowId",
        .workflow_owner_id = "workflowOwnerId",
        .workflow_type = "workflowType",
        .workflow_version_name = "workflowVersionName",
    };
};

pub const StartRunOutput = struct {
    /// Unique resource identifier for the run.
    arn: ?[]const u8 = null,

    /// The run's ID.
    id: ?[]const u8 = null,

    /// The destination for workflow outputs.
    run_output_uri: ?[]const u8 = null,

    /// The run's status.
    status: ?RunStatus = null,

    /// The run's tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The universally unique identifier for a run.
    uuid: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .run_output_uri = "runOutputUri",
        .status = "status",
        .tags = "tags",
        .uuid = "uuid",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartRunInput, options: CallOptions) !StartRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "omics");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/run";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.cache_behavior) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"cacheBehavior\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.cache_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"cacheId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.log_level) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"logLevel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"outputUri\":");
    try aws.json.writeValue(@TypeOf(input.output_uri), input.output_uri, allocator, &body_buf);
    has_prev = true;
    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.priority) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"priority\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"requestId\":");
    try aws.json.writeValue(@TypeOf(input.request_id), input.request_id, allocator, &body_buf);
    has_prev = true;
    if (input.retention_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"retentionMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.run_group_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"runGroupId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.run_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"runId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.storage_capacity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"storageCapacity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.storage_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"storageType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.workflow_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workflowId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.workflow_owner_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workflowOwnerId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.workflow_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workflowType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.workflow_version_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workflowVersionName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartRunOutput {
    var result: StartRunOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartRunOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotSupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .not_supported_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RangeNotSatisfiableException")) {
        return .{ .arena = arena, .kind = .{ .range_not_satisfiable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .request_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
