const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ArrayProperties = @import("array_properties.zig").ArrayProperties;
const ConsumableResourceProperties = @import("consumable_resource_properties.zig").ConsumableResourceProperties;
const ContainerOverrides = @import("container_overrides.zig").ContainerOverrides;
const JobDependency = @import("job_dependency.zig").JobDependency;
const EcsPropertiesOverride = @import("ecs_properties_override.zig").EcsPropertiesOverride;
const EksPropertiesOverride = @import("eks_properties_override.zig").EksPropertiesOverride;
const NodeOverrides = @import("node_overrides.zig").NodeOverrides;
const RetryStrategy = @import("retry_strategy.zig").RetryStrategy;
const JobTimeout = @import("job_timeout.zig").JobTimeout;

pub const SubmitJobInput = struct {
    /// The array properties for the submitted job, such as the size of the array.
    /// The array size
    /// can be between 2 and 10,000. If you specify array properties for a job, it
    /// becomes an array
    /// job. For more information, see [Array
    /// Jobs](https://docs.aws.amazon.com/batch/latest/userguide/array_jobs.html) in
    /// the *Batch User Guide*.
    array_properties: ?ArrayProperties = null,

    /// An object that contains overrides for the consumable resources of a job.
    consumable_resource_properties_override: ?ConsumableResourceProperties = null,

    /// An object with properties that override the defaults for the job definition
    /// that specify
    /// the name of a container in the specified job definition and the overrides it
    /// should receive.
    /// You can override the default command for a container, which is specified in
    /// the job definition
    /// or the Docker image, with a `command` override. You can also override
    /// existing
    /// environment variables on a container or add new environment variables to it
    /// with an
    /// `environment` override.
    container_overrides: ?ContainerOverrides = null,

    /// A list of dependencies for the job. A job can depend upon a maximum of 20
    /// jobs. You can
    /// specify a `SEQUENTIAL` type dependency without specifying a job ID for array
    /// jobs
    /// so that each child array job completes sequentially, starting at index 0.
    /// You can also specify
    /// an `N_TO_N` type dependency with a job ID for array jobs. In that case, each
    /// index
    /// child of this job must wait for the corresponding index child of each
    /// dependency to complete
    /// before it can begin.
    depends_on: ?[]const JobDependency = null,

    /// An object, with properties that override defaults for the job definition,
    /// can only be specified for jobs that are run on Amazon ECS resources.
    ecs_properties_override: ?EcsPropertiesOverride = null,

    /// An object, with properties that override defaults for the job definition,
    /// can only be specified for jobs that are run on Amazon EKS resources.
    eks_properties_override: ?EksPropertiesOverride = null,

    /// The job definition used by this job. This value can be one of
    /// `definition-name`, `definition-name:revision`, or the Amazon Resource Name
    /// (ARN) for the
    /// job definition, with or without the revision
    /// (`arn:aws:batch:*region*:*account*:job-definition/*definition-name*:*revision*
    /// `,
    /// or
    /// `arn:aws:batch:*region*:*account*:job-definition/*definition-name*
    /// `).
    ///
    /// If the revision is not specified, then the latest active revision is used.
    job_definition: []const u8,

    /// The name of the job. It can be up to 128 letters long. The first character
    /// must be
    /// alphanumeric, can contain uppercase and lowercase letters, numbers, hyphens
    /// (-), and
    /// underscores (_).
    job_name: []const u8,

    /// The job queue where the job is submitted. You can specify either the name or
    /// the Amazon Resource Name (ARN)
    /// of the queue.
    job_queue: []const u8,

    /// A list of node overrides in JSON format that specify the node range to
    /// target and the
    /// container overrides for that node range.
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources; use
    /// `containerOverrides` instead.
    node_overrides: ?NodeOverrides = null,

    /// Additional parameters passed to the job that replace parameter substitution
    /// placeholders
    /// that are set in the job definition. Parameters are specified as a key and
    /// value pair mapping.
    /// Parameters in a `SubmitJob` request override any corresponding parameter
    /// defaults
    /// from the job definition.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// Specifies whether to propagate the tags from the job or job definition to
    /// the
    /// corresponding Amazon ECS task. If no value is specified, the tags aren't
    /// propagated. Tags can only
    /// be propagated to the tasks during task creation. For tags with the same
    /// name, job tags are
    /// given priority over job definitions tags. If the total number of combined
    /// tags from the job
    /// and job definition is over 50, the job is moved to the `FAILED` state. When
    /// specified, this overrides the tag propagation setting in the job definition.
    propagate_tags: ?bool = null,

    /// The retry strategy to use for failed jobs from this SubmitJob operation.
    /// When a retry strategy is specified here, it overrides the retry strategy
    /// defined in the job
    /// definition.
    retry_strategy: ?RetryStrategy = null,

    /// The scheduling priority for the job. This only affects jobs in job queues
    /// with a
    /// fair-share policy. Jobs with a higher scheduling priority are scheduled
    /// before jobs with a lower
    /// scheduling priority. This overrides any scheduling priority in the job
    /// definition and works only
    /// within a single share identifier.
    ///
    /// The minimum supported value is 0 and the maximum supported value is 9999.
    scheduling_priority_override: ?i32 = null,

    /// The share identifier for the job. Don't specify this parameter if the job
    /// queue doesn't
    /// have a fair-share scheduling policy. If the job queue has a fair-share
    /// scheduling policy, then this parameter must
    /// be specified.
    ///
    /// This string is limited to 255 alphanumeric characters, and can be followed
    /// by an asterisk
    /// (*).
    share_identifier: ?[]const u8 = null,

    /// The tags that you apply to the job request to help you categorize and
    /// organize your
    /// resources. Each tag consists of a key and an optional value. For more
    /// information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in *Amazon Web Services General Reference*.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timeout configuration for this SubmitJob operation. You can specify
    /// a timeout duration after which Batch terminates your jobs if they haven't
    /// finished. If a job
    /// is terminated due to a timeout, it isn't retried. The minimum value for the
    /// timeout is 60
    /// seconds. This configuration overrides any timeout configuration specified in
    /// the job
    /// definition. For array jobs, child jobs have the same timeout configuration
    /// as the parent job.
    /// For more information, see [Job
    /// Timeouts](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/job_timeouts.html) in the
    /// *Amazon Elastic Container Service Developer Guide*.
    timeout: ?JobTimeout = null,

    pub const json_field_names = .{
        .array_properties = "arrayProperties",
        .consumable_resource_properties_override = "consumableResourcePropertiesOverride",
        .container_overrides = "containerOverrides",
        .depends_on = "dependsOn",
        .ecs_properties_override = "ecsPropertiesOverride",
        .eks_properties_override = "eksPropertiesOverride",
        .job_definition = "jobDefinition",
        .job_name = "jobName",
        .job_queue = "jobQueue",
        .node_overrides = "nodeOverrides",
        .parameters = "parameters",
        .propagate_tags = "propagateTags",
        .retry_strategy = "retryStrategy",
        .scheduling_priority_override = "schedulingPriorityOverride",
        .share_identifier = "shareIdentifier",
        .tags = "tags",
        .timeout = "timeout",
    };
};

pub const SubmitJobOutput = struct {
    /// The Amazon Resource Name (ARN) for the job.
    job_arn: ?[]const u8 = null,

    /// The unique identifier for the job.
    job_id: []const u8,

    /// The name of the job.
    job_name: []const u8,

    pub const json_field_names = .{
        .job_arn = "jobArn",
        .job_id = "jobId",
        .job_name = "jobName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SubmitJobInput, options: Options) !SubmitJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SubmitJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/submitjob";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.array_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"arrayProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.consumable_resource_properties_override) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"consumableResourcePropertiesOverride\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.container_overrides) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"containerOverrides\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.depends_on) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dependsOn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ecs_properties_override) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ecsPropertiesOverride\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.eks_properties_override) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"eksPropertiesOverride\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobDefinition\":");
    try aws.json.writeValue(@TypeOf(input.job_definition), input.job_definition, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobName\":");
    try aws.json.writeValue(@TypeOf(input.job_name), input.job_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobQueue\":");
    try aws.json.writeValue(@TypeOf(input.job_queue), input.job_queue, allocator, &body_buf);
    has_prev = true;
    if (input.node_overrides) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nodeOverrides\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parameters\":");
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
    if (input.scheduling_priority_override) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"schedulingPriorityOverride\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.share_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"shareIdentifier\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SubmitJobOutput {
    var result: SubmitJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SubmitJobOutput, body, allocator);
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
