const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceType = @import("service_type.zig").ServiceType;
const Recommendation = @import("recommendation.zig").Recommendation;

pub const ListPerformanceAnalysisReportRecommendationsInput = struct {
    /// A unique identifier of the created analysis report. For example,
    /// `report-12345678901234567`
    analysis_report_id: []const u8,

    /// An immutable identifier for a data source that is unique for an Amazon Web
    /// Services Region. Performance Insights gathers metrics from this data source.
    /// In the
    /// console, the identifier is shown as *ResourceID*. When you call
    /// `DescribeDBInstances`, the identifier is
    /// returned as `DbiResourceId`.
    ///
    /// To use a DB instance as a data source, specify its `DbiResourceId` value.
    /// For example, specify
    /// `db-ABCDEFGHIJKLMNOPQRSTU1VW2X`.
    identifier: []const u8,

    /// The maximum number of items to return in the response. If more items exist
    /// than the specified `MaxResults` value, a
    /// pagination token is included in the response so that the remaining results
    /// can be retrieved.
    max_results: ?i32 = null,

    /// An optional pagination token provided by a previous request.
    /// If this parameter is specified, the response includes only records beyond
    /// the token, up to the value specified by `MaxResults`.
    next_token: ?[]const u8 = null,

    /// A list of recommendation identifiers to filter the results.
    recommendation_ids: ?[]const []const u8 = null,

    /// The Amazon Web Services service for which Performance Insights returns
    /// metrics. Valid value is
    /// `RDS`.
    service_type: ServiceType,

    pub const json_field_names = .{
        .analysis_report_id = "AnalysisReportId",
        .identifier = "Identifier",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .recommendation_ids = "RecommendationIds",
        .service_type = "ServiceType",
    };
};

pub const ListPerformanceAnalysisReportRecommendationsOutput = struct {
    /// An optional pagination token provided by a previous request.
    /// If this parameter is specified, the response includes only records beyond
    /// the token,
    /// up to the value specified by `MaxResults`.
    next_token: ?[]const u8 = null,

    /// The list of recommendations for the analysis report.
    recommendations: ?[]const Recommendation = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .recommendations = "Recommendations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPerformanceAnalysisReportRecommendationsInput, options: CallOptions) !ListPerformanceAnalysisReportRecommendationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "pi", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPerformanceAnalysisReportRecommendationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pi", "PI", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PerformanceInsightsv20180227.ListPerformanceAnalysisReportRecommendations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPerformanceAnalysisReportRecommendationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPerformanceAnalysisReportRecommendationsOutput, body, allocator);
}
