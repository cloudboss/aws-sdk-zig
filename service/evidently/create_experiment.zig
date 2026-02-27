const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MetricGoalConfig = @import("metric_goal_config.zig").MetricGoalConfig;
const OnlineAbConfig = @import("online_ab_config.zig").OnlineAbConfig;
const TreatmentConfig = @import("treatment_config.zig").TreatmentConfig;
const Experiment = @import("experiment.zig").Experiment;

pub const CreateExperimentInput = struct {
    /// An optional description of the experiment.
    description: ?[]const u8 = null,

    /// An array of structures that defines the metrics used for the experiment, and
    /// whether a higher or lower value for each metric is the goal.
    metric_goals: []const MetricGoalConfig,

    /// A name for the new experiment.
    name: []const u8,

    /// A structure that contains the configuration of which variation to use as the
    /// "control" version. tThe "control" version is used for comparison with other
    /// variations. This structure also specifies how much experiment traffic is
    /// allocated to each variation.
    online_ab_config: ?OnlineAbConfig = null,

    /// The name or ARN of the project that you want to create the new experiment
    /// in.
    project: []const u8,

    /// When Evidently assigns a particular user session to an experiment, it must
    /// use a randomization ID to determine which variation the user session is
    /// served. This randomization ID is a combination of the entity ID and
    /// `randomizationSalt`. If you omit `randomizationSalt`, Evidently uses the
    /// experiment name as the `randomizationSalt`.
    randomization_salt: ?[]const u8 = null,

    /// The portion of the available audience that you want to allocate to this
    /// experiment, in thousandths of a percent. The available audience is the total
    /// audience minus the audience that you have allocated to overrides or current
    /// launches of this feature.
    ///
    /// This is represented in thousandths of a percent. For example, specify 10,000
    /// to allocate 10% of the available audience.
    sampling_rate: ?i64 = null,

    /// Specifies an audience *segment* to use in the experiment. When a segment is
    /// used in an experiment, only user sessions that match the segment pattern are
    /// used in the experiment.
    segment: ?[]const u8 = null,

    /// Assigns one or more tags (key-value pairs) to the experiment.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to scope user permissions by granting a user permission to access or
    /// change only resources with certain tag values.
    ///
    /// Tags don't have any semantic meaning to Amazon Web Services and are
    /// interpreted strictly as strings of characters.
    ///
    /// You can associate as many as 50 tags with an experiment.
    ///
    /// For more information, see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    /// An array of structures that describe the configuration of each feature
    /// variation used in the experiment.
    treatments: []const TreatmentConfig,

    pub const json_field_names = .{
        .description = "description",
        .metric_goals = "metricGoals",
        .name = "name",
        .online_ab_config = "onlineAbConfig",
        .project = "project",
        .randomization_salt = "randomizationSalt",
        .sampling_rate = "samplingRate",
        .segment = "segment",
        .tags = "tags",
        .treatments = "treatments",
    };
};

pub const CreateExperimentOutput = struct {
    /// A structure containing the configuration details of the experiment that you
    /// created.
    experiment: ?Experiment = null,

    pub const json_field_names = .{
        .experiment = "experiment",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateExperimentInput, options: Options) !CreateExperimentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "evidently");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateExperimentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("evidently", "Evidently", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/projects/");
    try path_buf.appendSlice(alloc, input.project);
    try path_buf.appendSlice(alloc, "/experiments");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"metricGoals\":");
    try aws.json.writeValue(@TypeOf(input.metric_goals), input.metric_goals, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, alloc, &body_buf);
    has_prev = true;
    if (input.online_ab_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"onlineAbConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.randomization_salt) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"randomizationSalt\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.sampling_rate) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"samplingRate\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.segment) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"segment\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"treatments\":");
    try aws.json.writeValue(@TypeOf(input.treatments), input.treatments, alloc, &body_buf);
    has_prev = true;

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateExperimentOutput {
    var result: CreateExperimentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateExperimentOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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
