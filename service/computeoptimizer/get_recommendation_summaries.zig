const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommendationSummary = @import("recommendation_summary.zig").RecommendationSummary;

pub const GetRecommendationSummariesInput = struct {
    /// The ID of the Amazon Web Services account for which to return recommendation
    /// summaries.
    ///
    /// If your account is the management account of an organization, use this
    /// parameter to
    /// specify the member account for which you want to return recommendation
    /// summaries.
    ///
    /// Only one account ID can be specified per request.
    account_ids: ?[]const []const u8 = null,

    /// The maximum number of recommendation summaries to return with a single
    /// request.
    ///
    /// To retrieve the remaining results, make another request with the returned
    /// `nextToken` value.
    max_results: ?i32 = null,

    /// The token to advance to the next page of recommendation summaries.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const GetRecommendationSummariesOutput = struct {
    /// The token to use to advance to the next page of recommendation summaries.
    ///
    /// This value is null when there are no more pages of recommendation summaries
    /// to
    /// return.
    next_token: ?[]const u8 = null,

    /// An array of objects that summarize a recommendation.
    recommendation_summaries: ?[]const RecommendationSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .recommendation_summaries = "recommendationSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRecommendationSummariesInput, options: CallOptions) !GetRecommendationSummariesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "compute-optimizer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRecommendationSummariesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("compute-optimizer", "Compute Optimizer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerService.GetRecommendationSummaries");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRecommendationSummariesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRecommendationSummariesOutput, body, allocator);
}
