const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommendationConfig = @import("recommendation_config.zig").RecommendationConfig;
const RecommendationType = @import("recommendation_type.zig").RecommendationType;
const RecommendationStatus = @import("recommendation_status.zig").RecommendationStatus;

pub const StartRecommendationInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, the service
    /// ignores the request, but does not return an error.
    client_token: ?[]const u8 = null,

    /// The description of the recommendation.
    description: ?[]const u8 = null,

    /// The name of the recommendation. Must be unique within your account.
    name: []const u8,

    /// The configuration for the recommendation, including the input to optimize,
    /// agent traces to analyze, and evaluation settings.
    recommendation_config: RecommendationConfig,

    /// The type of recommendation to generate. Valid values are
    /// `SYSTEM_PROMPT_RECOMMENDATION` for system prompt optimization or
    /// `TOOL_DESCRIPTION_RECOMMENDATION` for tool description optimization.
    @"type": RecommendationType,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .name = "name",
        .recommendation_config = "recommendationConfig",
        .@"type" = "type",
    };
};

pub const StartRecommendationOutput = struct {
    /// The timestamp when the recommendation was created.
    created_at: i64,

    /// The description of the recommendation.
    description: ?[]const u8 = null,

    /// The name of the recommendation.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the created recommendation.
    recommendation_arn: []const u8,

    /// The configuration for the recommendation.
    recommendation_config: ?RecommendationConfig = null,

    /// The unique identifier of the created recommendation.
    recommendation_id: []const u8,

    /// The status of the recommendation.
    status: RecommendationStatus,

    /// The type of recommendation.
    @"type": RecommendationType,

    /// The timestamp when the recommendation was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .name = "name",
        .recommendation_arn = "recommendationArn",
        .recommendation_config = "recommendationConfig",
        .recommendation_id = "recommendationId",
        .status = "status",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartRecommendationInput, options: CallOptions) !StartRecommendationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartRecommendationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/recommendations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"recommendationConfig\":");
    try aws.json.writeValue(@TypeOf(input.recommendation_config), input.recommendation_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartRecommendationOutput {
    var result: StartRecommendationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartRecommendationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
