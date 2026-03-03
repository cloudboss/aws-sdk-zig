const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AccelerationSettings = @import("acceleration_settings.zig").AccelerationSettings;
const HopDestination = @import("hop_destination.zig").HopDestination;
const JobTemplateSettings = @import("job_template_settings.zig").JobTemplateSettings;
const StatusUpdateInterval = @import("status_update_interval.zig").StatusUpdateInterval;
const JobTemplate = @import("job_template.zig").JobTemplate;

pub const CreateJobTemplateInput = struct {
    /// Accelerated transcoding can significantly speed up jobs with long, visually
    /// complex content. Outputs that use this feature incur pro-tier pricing. For
    /// information about feature limitations, see the AWS Elemental MediaConvert
    /// User Guide.
    acceleration_settings: ?AccelerationSettings = null,

    /// Optional. A category for the job template you are creating
    category: ?[]const u8 = null,

    /// Optional. A description of the job template you are creating.
    description: ?[]const u8 = null,

    /// Optional. Use queue hopping to avoid overly long waits in the backlog of the
    /// queue that you submit your job to. Specify an alternate queue and the
    /// maximum time that your job will wait in the initial queue before hopping.
    /// For more information about this feature, see the AWS Elemental MediaConvert
    /// User Guide.
    hop_destinations: ?[]const HopDestination = null,

    /// The name of the job template you are creating.
    name: []const u8,

    /// Specify the relative priority for this job. In any given queue, the service
    /// begins processing the job with the highest value first. When more than one
    /// job has the same priority, the service begins processing the job that you
    /// submitted first. If you don't specify a priority, the service uses the
    /// default value 0.
    priority: ?i32 = null,

    /// Optional. The queue that jobs created from this template are assigned to. If
    /// you don't specify this, jobs will go to the default queue.
    queue: ?[]const u8 = null,

    /// JobTemplateSettings contains all the transcode settings saved in the
    /// template that will be applied to jobs created from it.
    settings: JobTemplateSettings,

    /// Specify how often MediaConvert sends STATUS_UPDATE events to Amazon
    /// CloudWatch Events. Set the interval, in seconds, between status updates.
    /// MediaConvert sends an update at this interval from the time the service
    /// begins processing your job to the time it completes the transcode or
    /// encounters an error.
    status_update_interval: ?StatusUpdateInterval = null,

    /// The tags that you want to add to the resource. You can tag resources with a
    /// key-value pair or with only a key.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .acceleration_settings = "AccelerationSettings",
        .category = "Category",
        .description = "Description",
        .hop_destinations = "HopDestinations",
        .name = "Name",
        .priority = "Priority",
        .queue = "Queue",
        .settings = "Settings",
        .status_update_interval = "StatusUpdateInterval",
        .tags = "Tags",
    };
};

pub const CreateJobTemplateOutput = struct {
    /// A job template is a pre-made set of encoding instructions that you can use
    /// to quickly create a job.
    job_template: ?JobTemplate = null,

    pub const json_field_names = .{
        .job_template = "JobTemplate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateJobTemplateInput, options: CallOptions) !CreateJobTemplateOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateJobTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconvert", "MediaConvert", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/2017-08-29/jobTemplates";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.acceleration_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccelerationSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.category) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Category\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.hop_destinations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"HopDestinations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.priority) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Priority\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.queue) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Queue\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Settings\":");
    try aws.json.writeValue(@TypeOf(input.settings), input.settings, allocator, &body_buf);
    has_prev = true;
    if (input.status_update_interval) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StatusUpdateInterval\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateJobTemplateOutput {
    var result: CreateJobTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateJobTemplateOutput, body, allocator);
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
