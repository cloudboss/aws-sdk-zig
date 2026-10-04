const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetRecommenderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/recommenders/");
    try path_buf.appendSlice(allocator, input.recommender_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
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

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
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
