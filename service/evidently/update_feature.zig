const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const VariationConfig = @import("variation_config.zig").VariationConfig;
const FeatureEvaluationStrategy = @import("feature_evaluation_strategy.zig").FeatureEvaluationStrategy;
const Feature = @import("feature.zig").Feature;

pub const UpdateFeatureInput = struct {
    /// To update variation configurations for this feature, or add new ones,
    /// specify this structure. In this array, include any variations that you want
    /// to add or update. If the array includes a variation name that already exists
    /// for this feature, it is updated. If it includes a new variation name, it is
    /// added as a new variation.
    add_or_update_variations: ?[]const VariationConfig = null,

    /// The name of the variation to use as the default variation. The default
    /// variation is served to users who are not allocated to any ongoing launches
    /// or experiments of this feature.
    default_variation: ?[]const u8 = null,

    /// An optional description of the feature.
    description: ?[]const u8 = null,

    /// Specified users that should always be served a specific variation of a
    /// feature. Each user is specified by a key-value pair . For each key, specify
    /// a user by entering their user ID, account ID, or some other identifier. For
    /// the value, specify the name of the variation that they are to be served.
    ///
    /// This parameter is limited to 2500 overrides or a total of 40KB. The 40KB
    /// limit includes an overhead of 6 bytes per override.
    entity_overrides: ?[]const aws.map.StringMapEntry = null,

    /// Specify `ALL_RULES` to activate the traffic allocation specified by any
    /// ongoing launches or experiments. Specify `DEFAULT_VARIATION` to serve the
    /// default variation to all users instead.
    evaluation_strategy: ?FeatureEvaluationStrategy = null,

    /// The name of the feature to be updated.
    feature: []const u8,

    /// The name or ARN of the project that contains the feature to be updated.
    project: []const u8,

    /// Removes a variation from the feature. If the variation you specify doesn't
    /// exist, then this makes no change and does not report an error.
    ///
    /// This operation fails if you try to remove a variation that is part of an
    /// ongoing launch or experiment.
    remove_variations: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .add_or_update_variations = "addOrUpdateVariations",
        .default_variation = "defaultVariation",
        .description = "description",
        .entity_overrides = "entityOverrides",
        .evaluation_strategy = "evaluationStrategy",
        .feature = "feature",
        .project = "project",
        .remove_variations = "removeVariations",
    };
};

pub const UpdateFeatureOutput = struct {
    /// A structure that contains information about the updated feature.
    feature: ?Feature = null,

    pub const json_field_names = .{
        .feature = "feature",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFeatureInput, options: Options) !UpdateFeatureOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateFeatureInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("evidently", "Evidently", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/projects/");
    try path_buf.appendSlice(alloc, input.project);
    try path_buf.appendSlice(alloc, "/features/");
    try path_buf.appendSlice(alloc, input.feature);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.add_or_update_variations) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"addOrUpdateVariations\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.default_variation) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"defaultVariation\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.entity_overrides) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"entityOverrides\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.evaluation_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"evaluationStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.remove_variations) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"removeVariations\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateFeatureOutput {
    var result: UpdateFeatureOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateFeatureOutput, body, alloc);
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
