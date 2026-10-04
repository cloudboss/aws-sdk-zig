const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RightsizingRecommendationConfiguration = @import("rightsizing_recommendation_configuration.zig").RightsizingRecommendationConfiguration;
const Expression = @import("expression.zig").Expression;
const RightsizingRecommendationMetadata = @import("rightsizing_recommendation_metadata.zig").RightsizingRecommendationMetadata;
const RightsizingRecommendation = @import("rightsizing_recommendation.zig").RightsizingRecommendation;
const RightsizingRecommendationSummary = @import("rightsizing_recommendation_summary.zig").RightsizingRecommendationSummary;

pub const GetRightsizingRecommendationInput = struct {
    /// You can use Configuration to customize recommendations across two
    /// attributes. You can
    /// choose to view recommendations for instances within the same instance
    /// families or across
    /// different instance families. You can also choose to view your estimated
    /// savings that are
    /// associated with recommendations with consideration of existing Savings Plans
    /// or RI benefits,
    /// or neither.
    configuration: ?RightsizingRecommendationConfiguration = null,

    filter: ?Expression = null,

    /// The pagination token that indicates the next set of results that you want to
    /// retrieve.
    next_page_token: ?[]const u8 = null,

    /// The number of recommendations that you want returned in a single response
    /// object.
    page_size: ?i32 = null,

    /// The specific service that you want recommendations for. The only valid value
    /// for
    /// `GetRightsizingRecommendation` is "`AmazonEC2`".
    service: []const u8,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .filter = "Filter",
        .next_page_token = "NextPageToken",
        .page_size = "PageSize",
        .service = "Service",
    };
};

pub const GetRightsizingRecommendationOutput = struct {
    /// You can use Configuration to customize recommendations across two
    /// attributes. You can
    /// choose to view recommendations for instances within the same instance
    /// families or across
    /// different instance families. You can also choose to view your estimated
    /// savings that are
    /// associated with recommendations with consideration of existing Savings Plans
    /// or RI benefits,
    /// or neither.
    configuration: ?RightsizingRecommendationConfiguration = null,

    /// Information regarding this specific recommendation set.
    metadata: ?RightsizingRecommendationMetadata = null,

    /// The token to retrieve the next set of results.
    next_page_token: ?[]const u8 = null,

    /// Recommendations to rightsize resources.
    rightsizing_recommendations: ?[]const RightsizingRecommendation = null,

    /// Summary of this recommendation set.
    summary: ?RightsizingRecommendationSummary = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .metadata = "Metadata",
        .next_page_token = "NextPageToken",
        .rightsizing_recommendations = "RightsizingRecommendations",
        .summary = "Summary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRightsizingRecommendationInput, options: CallOptions) !GetRightsizingRecommendationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRightsizingRecommendationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ce", "Cost Explorer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetRightsizingRecommendation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRightsizingRecommendationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRightsizingRecommendationOutput, body, allocator);
}
