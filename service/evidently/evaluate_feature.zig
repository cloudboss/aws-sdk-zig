const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const VariableValue = @import("variable_value.zig").VariableValue;

pub const EvaluateFeatureInput = struct {
    /// An internal ID that represents a unique user of the application. This
    /// `entityID` is checked against any override rules assigned for this feature.
    entity_id: []const u8,

    /// A JSON object of attributes that you can optionally pass in as part of the
    /// evaluation event sent to Evidently from the user session. Evidently can use
    /// this value to match user sessions with defined audience segments. For more
    /// information, see [Use segments to focus your
    /// audience](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Evidently-segments.html).
    ///
    /// If you include this parameter, the value must be a JSON object. A JSON array
    /// is not supported.
    evaluation_context: ?[]const u8 = null,

    /// The name of the feature being evaluated.
    feature: []const u8,

    /// The name or ARN of the project that contains this feature.
    project: []const u8,

    pub const json_field_names = .{
        .entity_id = "entityId",
        .evaluation_context = "evaluationContext",
        .feature = "feature",
        .project = "project",
    };
};

pub const EvaluateFeatureOutput = struct {
    /// If this user was assigned to a launch or experiment, this field lists the
    /// launch or experiment name.
    details: ?[]const u8 = null,

    /// Specifies the reason that the user session was assigned this variation.
    /// Possible values include `DEFAULT`, meaning the user was served the default
    /// variation; `LAUNCH_RULE_MATCH`, if the user session was enrolled in a
    /// launch; `EXPERIMENT_RULE_MATCH`, if the user session was enrolled in an
    /// experiment; or `ENTITY_OVERRIDES_MATCH`, if the user's `entityId` matches an
    /// override rule.
    reason: ?[]const u8 = null,

    /// The value assigned to this variation to differentiate it from the other
    /// variations of this feature.
    value: ?VariableValue = null,

    /// The name of the variation that was served to the user session.
    variation: ?[]const u8 = null,

    pub const json_field_names = .{
        .details = "details",
        .reason = "reason",
        .value = "value",
        .variation = "variation",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EvaluateFeatureInput, options: Options) !EvaluateFeatureOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: EvaluateFeatureInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("evidently", "Evidently", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/projects/");
    try path_buf.appendSlice(allocator, input.project);
    try path_buf.appendSlice(allocator, "/evaluations/");
    try path_buf.appendSlice(allocator, input.feature);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"entityId\":");
    try aws.json.writeValue(@TypeOf(input.entity_id), input.entity_id, allocator, &body_buf);
    has_prev = true;
    if (input.evaluation_context) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"evaluationContext\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EvaluateFeatureOutput {
    var result: EvaluateFeatureOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(EvaluateFeatureOutput, body, allocator);
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
