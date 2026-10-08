const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommendationConfig = @import("recommendation_config.zig").RecommendationConfig;
const RecommendationResult = @import("recommendation_result.zig").RecommendationResult;
const RecommendationStatus = @import("recommendation_status.zig").RecommendationStatus;
const RecommendationType = @import("recommendation_type.zig").RecommendationType;

pub const GetRecommendationInput = struct {
    /// The unique identifier of the recommendation to retrieve.
    recommendation_id: []const u8,

    pub const json_field_names = .{
        .recommendation_id = "recommendationId",
    };
};

pub const GetRecommendationOutput = struct {
    /// The timestamp when the recommendation was created.
    created_at: i64,

    /// The description of the recommendation.
    description: ?[]const u8 = null,

    /// The ARN of the KMS key used to encrypt recommendation data.
    kms_key_arn: ?[]const u8 = null,

    /// The name of the recommendation.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the recommendation.
    recommendation_arn: []const u8,

    /// The configuration for the recommendation.
    recommendation_config: ?RecommendationConfig = null,

    /// The unique identifier of the recommendation.
    recommendation_id: []const u8,

    /// The result of the recommendation, containing the optimized system prompt or
    /// tool descriptions. Only present when the recommendation status is
    /// `COMPLETED`.
    recommendation_result: ?RecommendationResult = null,

    /// The current status of the recommendation.
    status: RecommendationStatus,

    /// The type of recommendation.
    type: RecommendationType,

    /// The timestamp when the recommendation was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .recommendation_arn = "recommendationArn",
        .recommendation_config = "recommendationConfig",
        .recommendation_id = "recommendationId",
        .recommendation_result = "recommendationResult",
        .status = "status",
        .type = "type",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRecommendationInput, options: CallOptions) !GetRecommendationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRecommendationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/recommendations/");
    try path_buf.appendSlice(allocator, input.recommendation_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRecommendationOutput {
    const result: GetRecommendationOutput = try aws.json.parseJsonObject(
        GetRecommendationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
