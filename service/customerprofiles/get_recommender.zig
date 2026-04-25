const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RecommenderUpdate = @import("recommender_update.zig").RecommenderUpdate;
const RecommenderConfig = @import("recommender_config.zig").RecommenderConfig;
const RecommenderRecipeName = @import("recommender_recipe_name.zig").RecommenderRecipeName;
const RecommenderStatus = @import("recommender_status.zig").RecommenderStatus;
const TrainingMetrics = @import("training_metrics.zig").TrainingMetrics;

pub const GetRecommenderInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The name of the recommender.
    recommender_name: []const u8,

    /// The number of training metrics to retrieve for the recommender.
    training_metrics_count: ?i32 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .recommender_name = "RecommenderName",
        .training_metrics_count = "TrainingMetricsCount",
    };
};

pub const GetRecommenderOutput = struct {
    /// The timestamp of when the recommender was created.
    created_at: ?i64 = null,

    /// A detailed description of the recommender providing information about its
    /// purpose and functionality.
    description: ?[]const u8 = null,

    /// If the recommender fails, provides the reason for the failure.
    failure_reason: ?[]const u8 = null,

    /// The timestamp of when the recommender was edited.
    last_updated_at: ?i64 = null,

    /// Information about the most recent update performed on the recommender,
    /// including status and timestamp.
    latest_recommender_update: ?RecommenderUpdate = null,

    /// The configuration settings for the recommender, including parameters and
    /// settings that define its behavior.
    recommender_config: ?RecommenderConfig = null,

    /// The name of the recommender.
    recommender_name: []const u8,

    /// The name of the recipe used by the recommender to generate recommendations.
    recommender_recipe_name: RecommenderRecipeName,

    /// The name of the recommender schema associated with this recommender.
    recommender_schema_name: ?[]const u8 = null,

    /// The current status of the recommender, indicating whether it is active,
    /// creating, updating, or in another state.
    status: ?RecommenderStatus = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A set of metrics that provide information about the recommender's training
    /// performance and accuracy.
    training_metrics: ?[]const TrainingMetrics = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .failure_reason = "FailureReason",
        .last_updated_at = "LastUpdatedAt",
        .latest_recommender_update = "LatestRecommenderUpdate",
        .recommender_config = "RecommenderConfig",
        .recommender_name = "RecommenderName",
        .recommender_recipe_name = "RecommenderRecipeName",
        .recommender_schema_name = "RecommenderSchemaName",
        .status = "Status",
        .tags = "Tags",
        .training_metrics = "TrainingMetrics",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRecommenderInput, options: CallOptions) !GetRecommenderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "profile");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRecommenderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/recommenders/");
    try path_buf.appendSlice(allocator, input.recommender_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.training_metrics_count) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "training-metrics-count=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRecommenderOutput {
    var result: GetRecommenderOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRecommenderOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
