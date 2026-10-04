const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RDSDBRecommendationFilter = @import("rdsdb_recommendation_filter.zig").RDSDBRecommendationFilter;
const RecommendationPreferences = @import("recommendation_preferences.zig").RecommendationPreferences;
const GetRecommendationError = @import("get_recommendation_error.zig").GetRecommendationError;
const RDSDBRecommendation = @import("rdsdb_recommendation.zig").RDSDBRecommendation;

pub const GetRDSDatabaseRecommendationsInput = struct {
    /// Return the Amazon Aurora and RDS database recommendations to the specified
    /// Amazon Web Services account IDs.
    ///
    /// If your account is the management account or the delegated administrator
    /// of an organization, use this parameter to return the Amazon Aurora and RDS
    /// database recommendations to specific
    /// member accounts.
    ///
    /// You can only specify one account ID per request.
    account_ids: ?[]const []const u8 = null,

    /// An array of objects to specify a filter that returns a more specific list of
    /// Amazon Aurora and RDS database recommendations.
    filters: ?[]const RDSDBRecommendationFilter = null,

    /// The maximum number of Amazon Aurora and RDS database recommendations to
    /// return with a single
    /// request.
    ///
    /// To retrieve the remaining results, make another request with the returned
    /// `nextToken` value.
    max_results: ?i32 = null,

    /// The token to advance to the next page of Amazon Aurora and RDS database
    /// recommendations.
    next_token: ?[]const u8 = null,

    recommendation_preferences: ?RecommendationPreferences = null,

    /// The ARN that identifies the Amazon Aurora or RDS database.
    ///
    /// The following is the format of the ARN:
    ///
    /// `arn:aws:rds:{region}:{accountId}:db:{resourceName}`
    ///
    /// The following is the format of a DB Cluster ARN:
    ///
    /// `arn:aws:rds:{region}:{accountId}:cluster:{resourceName}`
    resource_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .recommendation_preferences = "recommendationPreferences",
        .resource_arns = "resourceArns",
    };
};

pub const GetRDSDatabaseRecommendationsOutput = struct {
    /// An array of objects that describe errors of the request.
    errors: ?[]const GetRecommendationError = null,

    /// The token to advance to the next page of Amazon Aurora and RDS database
    /// recommendations.
    next_token: ?[]const u8 = null,

    /// An array of objects that describe the Amazon Aurora and RDS database
    /// recommendations.
    rds_db_recommendations: ?[]const RDSDBRecommendation = null,

    pub const json_field_names = .{
        .errors = "errors",
        .next_token = "nextToken",
        .rds_db_recommendations = "rdsDBRecommendations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRDSDatabaseRecommendationsInput, options: CallOptions) !GetRDSDatabaseRecommendationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRDSDatabaseRecommendationsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerService.GetRDSDatabaseRecommendations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRDSDatabaseRecommendationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRDSDatabaseRecommendationsOutput, body, allocator);
}
