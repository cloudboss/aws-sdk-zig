const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ConsumableResourceProperties = @import("consumable_resource_properties.zig").ConsumableResourceProperties;
const ContainerProperties = @import("container_properties.zig").ContainerProperties;
const EcsProperties = @import("ecs_properties.zig").EcsProperties;
const EksProperties = @import("eks_properties.zig").EksProperties;
const NodeProperties = @import("node_properties.zig").NodeProperties;
const PlatformCapability = @import("platform_capability.zig").PlatformCapability;
const RetryStrategy = @import("retry_strategy.zig").RetryStrategy;
const JobTimeout = @import("job_timeout.zig").JobTimeout;
const JobDefinitionType = @import("job_definition_type.zig").JobDefinitionType;

pub const RegisterJobDefinitionInput = struct {
    /// Contains a list of consumable resources required by the job.
    consumable_resource_properties: ?ConsumableResourceProperties = null,

    /// An object with properties specific to Amazon ECS-based single-node
    /// container-based jobs. If the
    /// job definition's `type` parameter is `container`, then you must specify
    /// either `containerProperties` or `nodeProperties`. This must not be
    /// specified for Amazon EKS-based job definitions.
    ///
    /// If the job runs on Fargate resources, then you must not specify
    /// `nodeProperties`; use only `containerProperties`.
    container_properties: ?ContainerProperties = null,

    /// An object with properties that are specific to Amazon ECS-based jobs. This
    /// must not be
    /// specified for Amazon EKS-based job definitions.
    ecs_properties: ?EcsProperties = null,

    /// An object with properties that are specific to Amazon EKS-based jobs. This
    /// must not be
    /// specified for Amazon ECS based job definitions.
    eks_properties: ?EksProperties = null,

    /// The name of the job definition to register. It can be up to 128 letters
    /// long. It can
    /// contain uppercase and lowercase letters, numbers, hyphens (-), and
    /// underscores (_).
    job_definition_name: []const u8,

    /// An object with properties specific to multi-node parallel jobs. If you
    /// specify node
    /// properties for a job, it becomes a multi-node parallel job. For more
    /// information, see [Multi-node Parallel
    /// Jobs](https://docs.aws.amazon.com/batch/latest/userguide/multi-node-parallel-jobs.html) in the *Batch User Guide*.
    ///
    /// If the job runs on Fargate resources, then you must not specify
    /// `nodeProperties`; use `containerProperties` instead.
    ///
    /// If the job runs on Amazon EKS resources, then you must not specify
    /// `nodeProperties`.
    node_properties: ?NodeProperties = null,

    /// Default parameter substitution placeholders to set in the job definition.
    /// Parameters are
    /// specified as a key-value pair mapping. Parameters in a `SubmitJob` request
    /// override
    /// any corresponding parameter defaults from the job definition.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The platform capabilities required by the job definition. If no value is
    /// specified, it
    /// defaults to `EC2`. To run the job on Fargate resources, specify
    /// `FARGATE`.
    ///
    /// If the job runs on Amazon EKS resources, then you must not specify
    /// `platformCapabilities`.
    platform_capabilities: ?[]const PlatformCapability = null,

    /// Specifies whether to propagate the tags from the job or job definition to
    /// the
    /// corresponding Amazon ECS task. If no value is specified, the tags are not
    /// propagated. Tags can only
    /// be propagated to the tasks during task creation. For tags with the same
    /// name, job tags are
    /// given priority over job definitions tags. If the total number of combined
    /// tags from the job
    /// and job definition is over 50, the job is moved to the `FAILED` state.
    ///
    /// If the job runs on Amazon EKS resources, then you must not specify
    /// `propagateTags`.
    propagate_tags: ?bool = null,

    /// The retry strategy to use for failed jobs that are submitted with this job
    /// definition. Any
    /// retry strategy that's specified during a SubmitJob operation overrides the
    /// retry strategy defined here. If a job is terminated due to a timeout, it
    /// isn't retried.
    retry_strategy: ?RetryStrategy = null,

    /// The scheduling priority for jobs that are submitted with this job
    /// definition. This only
    /// affects jobs in job queues with a fair-share policy. Jobs with a higher
    /// scheduling priority
    /// are scheduled before jobs with a lower scheduling priority.
    ///
    /// The minimum supported value is 0 and the maximum supported value is 9999.
    scheduling_priority: ?i32 = null,

    /// The tags that you apply to the job definition to help you categorize and
    /// organize your
    /// resources. Each tag consists of a key and an optional value. For more
    /// information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/batch/latest/userguide/using-tags.html) in
    /// *Batch User Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timeout configuration for jobs that are submitted with this job
    /// definition, after
    /// which Batch terminates your jobs if they have not finished. If a job is
    /// terminated due to a
    /// timeout, it isn't retried. The minimum value for the timeout is 60 seconds.
    /// Any timeout
    /// configuration that's specified during a SubmitJob operation overrides the
    /// timeout configuration defined here. For more information, see [Job
    /// Timeouts](https://docs.aws.amazon.com/batch/latest/userguide/job_timeouts.html) in the
    /// *Batch User Guide*.
    timeout: ?JobTimeout = null,

    /// The type of job definition. For more information about multi-node parallel
    /// jobs, see
    /// [Creating a multi-node
    /// parallel job
    /// definition](https://docs.aws.amazon.com/batch/latest/userguide/multi-node-job-def.html) in the *Batch User Guide*.
    ///
    /// * If the value is `container`, then one of the following is required:
    ///   `containerProperties`, `ecsProperties`, or `eksProperties`.
    ///
    /// * If the value is `multinode`, then `nodeProperties` is required.
    ///
    /// If the job is run on Fargate resources, then `multinode` isn't supported.
    @"type": JobDefinitionType,

    pub const json_field_names = .{
        .consumable_resource_properties = "consumableResourceProperties",
        .container_properties = "containerProperties",
        .ecs_properties = "ecsProperties",
        .eks_properties = "eksProperties",
        .job_definition_name = "jobDefinitionName",
        .node_properties = "nodeProperties",
        .parameters = "parameters",
        .platform_capabilities = "platformCapabilities",
        .propagate_tags = "propagateTags",
        .retry_strategy = "retryStrategy",
        .scheduling_priority = "schedulingPriority",
        .tags = "tags",
        .timeout = "timeout",
        .@"type" = "type",
    };
};

pub const RegisterJobDefinitionOutput = struct {
    /// The Amazon Resource Name (ARN) of the job definition.
    job_definition_arn: []const u8,

    /// The name of the job definition.
    job_definition_name: []const u8,

    /// The revision of the job definition.
    revision: i32,

    pub const json_field_names = .{
        .job_definition_arn = "jobDefinitionArn",
        .job_definition_name = "jobDefinitionName",
        .revision = "revision",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterJobDefinitionInput, options: CallOptions) !RegisterJobDefinitionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "batch");

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterJobDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/registerjobdefinition";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.consumable_resource_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"consumableResourceProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.container_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"containerProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ecs_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ecsProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.eks_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"eksProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobDefinitionName\":");
    try aws.json.writeValue(@TypeOf(input.job_definition_name), input.job_definition_name, allocator, &body_buf);
    has_prev = true;
    if (input.node_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nodeProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.platform_capabilities) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"platformCapabilities\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.propagate_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"propagateTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.retry_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"retryStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.scheduling_priority) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"schedulingPriority\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.timeout) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"timeout\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterJobDefinitionOutput {
    var result: RegisterJobDefinitionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RegisterJobDefinitionOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ClientException")) {
        return .{ .arena = arena, .kind = .{ .client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerException")) {
        return .{ .arena = arena, .kind = .{ .server_exception = .{
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
