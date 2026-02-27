const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AccelerationSettings = @import("acceleration_settings.zig").AccelerationSettings;
const BillingTagsSource = @import("billing_tags_source.zig").BillingTagsSource;
const HopDestination = @import("hop_destination.zig").HopDestination;
const JobSettings = @import("job_settings.zig").JobSettings;
const SimulateReservedQueue = @import("simulate_reserved_queue.zig").SimulateReservedQueue;
const StatusUpdateInterval = @import("status_update_interval.zig").StatusUpdateInterval;
const Job = @import("job.zig").Job;

pub const CreateJobInput = struct {
    /// Optional. Accelerated transcoding can significantly speed up jobs with long,
    /// visually complex content. Outputs that use this feature incur pro-tier
    /// pricing. For information about feature limitations, see the AWS Elemental
    /// MediaConvert User Guide.
    acceleration_settings: ?AccelerationSettings = null,

    /// Optionally choose a Billing tags source that AWS Billing and Cost Management
    /// will use to display tags for individual output costs on any billing report
    /// that you set up. Leave blank to use the default value, Job.
    billing_tags_source: ?BillingTagsSource = null,

    /// Prevent duplicate jobs from being created and ensure idempotency for your
    /// requests. A client request token can be any string that includes up to 64
    /// ASCII characters. If you reuse a client request token within one minute of a
    /// successful request, the API returns the job details of the original request
    /// instead. For more information see
    /// https://docs.aws.amazon.com/mediaconvert/latest/apireference/idempotency.html.
    client_request_token: ?[]const u8 = null,

    /// Optional. Use queue hopping to avoid overly long waits in the backlog of the
    /// queue that you submit your job to. Specify an alternate queue and the
    /// maximum time that your job will wait in the initial queue before hopping.
    /// For more information about this feature, see the AWS Elemental MediaConvert
    /// User Guide.
    hop_destinations: ?[]const HopDestination = null,

    /// Use Job engine versions to run jobs for your production workflow on one
    /// version, while you test and validate the latest version. Job engine versions
    /// represent periodically grouped MediaConvert releases with new features,
    /// updates, improvements, and fixes. Job engine versions are in a YYYY-MM-DD
    /// format. Note that the Job engine version feature is not publicly available
    /// at this time. To request access, contact AWS support.
    job_engine_version: ?[]const u8 = null,

    /// Optional. When you create a job, you can either specify a job template or
    /// specify the transcoding settings individually.
    job_template: ?[]const u8 = null,

    /// Optional. Specify the relative priority for this job. In any given queue,
    /// the service begins processing the job with the highest value first. When
    /// more than one job has the same priority, the service begins processing the
    /// job that you submitted first. If you don't specify a priority, the service
    /// uses the default value 0.
    priority: ?i32 = null,

    /// Optional. When you create a job, you can specify a queue to send it to. If
    /// you don't specify, the job will go to the default queue. For more about
    /// queues, see the User Guide topic at
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/what-is.html.
    queue: ?[]const u8 = null,

    /// Required. The IAM role you use for creating this job. For details about
    /// permissions, see the User Guide topic at the User Guide at
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/iam-role.html.
    role: []const u8,

    /// JobSettings contains all the transcode settings for a job.
    settings: JobSettings,

    /// Optional. Enable this setting when you run a test job to estimate how many
    /// reserved transcoding slots (RTS) you need. When this is enabled,
    /// MediaConvert runs your job from an on-demand queue with similar performance
    /// to what you will see with one RTS in a reserved queue. This setting is
    /// disabled by default.
    simulate_reserved_queue: ?SimulateReservedQueue = null,

    /// Optional. Specify how often MediaConvert sends STATUS_UPDATE events to
    /// Amazon CloudWatch Events. Set the interval, in seconds, between status
    /// updates. MediaConvert sends an update at this interval from the time the
    /// service begins processing your job to the time it completes the transcode or
    /// encounters an error.
    status_update_interval: ?StatusUpdateInterval = null,

    /// Optional. The tags that you want to add to the resource. You can tag
    /// resources with a key-value pair or with only a key. Use standard AWS tags on
    /// your job for automatic integration with AWS services and for custom
    /// integrations and workflows.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Optional. User-defined metadata that you want to associate with an
    /// MediaConvert job. You specify metadata in key/value pairs. Use only for
    /// existing integrations or workflows that rely on job metadata tags.
    /// Otherwise, we recommend that you use standard AWS tags.
    user_metadata: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .acceleration_settings = "AccelerationSettings",
        .billing_tags_source = "BillingTagsSource",
        .client_request_token = "ClientRequestToken",
        .hop_destinations = "HopDestinations",
        .job_engine_version = "JobEngineVersion",
        .job_template = "JobTemplate",
        .priority = "Priority",
        .queue = "Queue",
        .role = "Role",
        .settings = "Settings",
        .simulate_reserved_queue = "SimulateReservedQueue",
        .status_update_interval = "StatusUpdateInterval",
        .tags = "Tags",
        .user_metadata = "UserMetadata",
    };
};

pub const CreateJobOutput = struct {
    /// Each job converts an input file into an output file or files. For more
    /// information, see the User Guide at
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/what-is.html
    job: ?Job = null,

    pub const json_field_names = .{
        .job = "Job",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateJobInput, options: Options) !CreateJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mediaconvert");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconvert", "MediaConvert", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/2017-08-29/jobs";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.acceleration_settings) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AccelerationSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.billing_tags_source) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"BillingTagsSource\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ClientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.hop_destinations) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"HopDestinations\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.job_engine_version) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"JobEngineVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.job_template) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"JobTemplate\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.priority) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Priority\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.queue) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Queue\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Role\":");
    try aws.json.writeValue(@TypeOf(input.role), input.role, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Settings\":");
    try aws.json.writeValue(@TypeOf(input.settings), input.settings, alloc, &body_buf);
    has_prev = true;
    if (input.simulate_reserved_queue) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SimulateReservedQueue\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.status_update_interval) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"StatusUpdateInterval\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.user_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"UserMetadata\":");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateJobOutput {
    var result: CreateJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateJobOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
