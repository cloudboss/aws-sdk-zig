const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartSavingsPlansPurchaseRecommendationGenerationInput = struct {};

pub const StartSavingsPlansPurchaseRecommendationGenerationOutput = struct {
    /// The estimated time for when the recommendation generation will complete.
    estimated_completion_time: ?[]const u8 = null,

    /// The start time of the recommendation generation.
    generation_started_time: ?[]const u8 = null,

    /// The ID for this specific recommendation.
    recommendation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .estimated_completion_time = "EstimatedCompletionTime",
        .generation_started_time = "GenerationStartedTime",
        .recommendation_id = "RecommendationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSavingsPlansPurchaseRecommendationGenerationInput, options: CallOptions) !StartSavingsPlansPurchaseRecommendationGenerationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartSavingsPlansPurchaseRecommendationGenerationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("ce", "Cost Explorer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.StartSavingsPlansPurchaseRecommendationGeneration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartSavingsPlansPurchaseRecommendationGenerationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartSavingsPlansPurchaseRecommendationGenerationOutput, body, allocator);
}
