const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ComputeEnvironmentOrder = @import("compute_environment_order.zig").ComputeEnvironmentOrder;
const JobQueueType = @import("job_queue_type.zig").JobQueueType;
const JobStateTimeLimitAction = @import("job_state_time_limit_action.zig").JobStateTimeLimitAction;
const ServiceEnvironmentOrder = @import("service_environment_order.zig").ServiceEnvironmentOrder;
const JQState = @import("jq_state.zig").JQState;

pub const CreateJobQueueInput = struct {
    /// The set of compute environments mapped to a job queue and their order
    /// relative to each
    /// other. The job scheduler uses this parameter to determine which compute
    /// environment runs a
    /// specific job. Compute environments must be in the `VALID` state before you
    /// can
    /// associate them with a job queue. You can associate up to three compute
    /// environments with a job
    /// queue. All of the compute environments must be either EC2 (`EC2` or
    /// `SPOT`) or Fargate (`FARGATE` or `FARGATE_SPOT`); EC2 and
    /// Fargate compute environments can't be mixed.
    ///
    /// All compute environments that are associated with a job queue must share the
    /// same
    /// architecture. Batch doesn't support mixing compute environment architecture
    /// types in a
    /// single job queue.
    compute_environment_order: ?[]const ComputeEnvironmentOrder = null,

    /// The name of the job queue. It can be up to 128 letters long. It can contain
    /// uppercase and
    /// lowercase letters, numbers, hyphens (-), and underscores (_).
    job_queue_name: []const u8,

    /// The type of job queue. For service jobs that run on SageMaker Training, this
    /// value is `SAGEMAKER_TRAINING`. For regular container jobs, this value is
    /// `EKS`, `ECS`, or `ECS_FARGATE` depending on the compute environment.
    job_queue_type: ?JobQueueType = null,

    /// The set of actions that Batch performs on jobs that remain at the head of
    /// the job queue in the specified state longer than specified times. Batch will
    /// perform each action after `maxTimeSeconds` has passed. (**Note**: The
    /// minimum value for maxTimeSeconds is 600 (10 minutes) and its maximum value
    /// is 86,400 (24 hours).)
    job_state_time_limit_actions: ?[]const JobStateTimeLimitAction = null,

    /// The priority of the job queue. Job queues with a higher priority (or a
    /// higher integer
    /// value for the `priority` parameter) are evaluated first when associated with
    /// the
    /// same compute environment. Priority is determined in descending order. For
    /// example, a job queue
    /// with a priority value of `10` is given scheduling preference over a job
    /// queue with
    /// a priority value of `1`. All of the compute environments must be either EC2
    /// (`EC2` or `SPOT`) or Fargate (`FARGATE` or
    /// `FARGATE_SPOT`); EC2 and Fargate compute environments can't be mixed.
    priority: i32,

    /// The Amazon Resource Name (ARN) of the fair-share scheduling policy. Job
    /// queues that don't have a fair-share scheduling policy are scheduled in a
    /// first-in, first-out (FIFO) model. After a job queue has a fair-share
    /// scheduling policy, it can be replaced but can't be removed.
    ///
    /// The format is
    /// `aws:*Partition*:batch:*Region*:*Account*:scheduling-policy/*Name*
    /// `.
    ///
    /// An example is
    /// `aws:aws:batch:us-west-2:123456789012:scheduling-policy/MySchedulingPolicy`.
    ///
    /// A job queue without a fair-share scheduling policy is scheduled as a FIFO
    /// job queue and can't have a fair-share scheduling policy added. Jobs queues
    /// with a fair-share scheduling policy can have a maximum of 500 active share
    /// identifiers. When the limit has been reached, submissions of any jobs that
    /// add a new share identifier fail.
    scheduling_policy_arn: ?[]const u8 = null,

    /// A list of service environments that this job queue can use to allocate jobs.
    /// All serviceEnvironments must have the same type. A job queue can't have both
    /// a serviceEnvironmentOrder and a computeEnvironmentOrder field.
    service_environment_order: ?[]const ServiceEnvironmentOrder = null,

    /// The state of the job queue. If the job queue state is `ENABLED`, it is able
    /// to
    /// accept jobs. If the job queue state is `DISABLED`, new jobs can't be added
    /// to the
    /// queue, but jobs already in the queue can finish.
    state: ?JQState = null,

    /// The tags that you apply to the job queue to help you categorize and organize
    /// your
    /// resources. Each tag consists of a key and an optional value. For more
    /// information, see [Tagging your Batch
    /// resources](https://docs.aws.amazon.com/batch/latest/userguide/using-tags.html)
    /// in *Batch User Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .compute_environment_order = "computeEnvironmentOrder",
        .job_queue_name = "jobQueueName",
        .job_queue_type = "jobQueueType",
        .job_state_time_limit_actions = "jobStateTimeLimitActions",
        .priority = "priority",
        .scheduling_policy_arn = "schedulingPolicyArn",
        .service_environment_order = "serviceEnvironmentOrder",
        .state = "state",
        .tags = "tags",
    };
};

pub const CreateJobQueueOutput = struct {
    /// The Amazon Resource Name (ARN) of the job queue.
    job_queue_arn: []const u8,

    /// The name of the job queue.
    job_queue_name: []const u8,

    pub const json_field_names = .{
        .job_queue_arn = "jobQueueArn",
        .job_queue_name = "jobQueueName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateJobQueueInput, options: Options) !CreateJobQueueOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateJobQueueInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/createjobqueue";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.compute_environment_order) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"computeEnvironmentOrder\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"jobQueueName\":");
    try aws.json.writeValue(@TypeOf(input.job_queue_name), input.job_queue_name, alloc, &body_buf);
    has_prev = true;
    if (input.job_queue_type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"jobQueueType\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.job_state_time_limit_actions) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"jobStateTimeLimitActions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"priority\":");
    try aws.json.writeValue(@TypeOf(input.priority), input.priority, alloc, &body_buf);
    has_prev = true;
    if (input.scheduling_policy_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"schedulingPolicyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.service_environment_order) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"serviceEnvironmentOrder\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.state) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"state\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateJobQueueOutput {
    var result: CreateJobQueueOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateJobQueueOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
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
