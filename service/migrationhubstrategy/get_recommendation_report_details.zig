const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommendationReportDetails = @import("recommendation_report_details.zig").RecommendationReportDetails;

pub const GetRecommendationReportDetailsInput = struct {
    /// The recommendation report generation task `id` returned by
    /// StartRecommendationReportGeneration.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetRecommendationReportDetailsOutput = struct {
    /// The ID of the recommendation report generation task. See the response of
    /// StartRecommendationReportGeneration.
    id: ?[]const u8 = null,

    /// Detailed information about the recommendation report.
    recommendation_report_details: ?RecommendationReportDetails = null,

    pub const json_field_names = .{
        .id = "id",
        .recommendation_report_details = "recommendationReportDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRecommendationReportDetailsInput, options: CallOptions) !GetRecommendationReportDetailsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsmigrationhubstrategyrecommendation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRecommendationReportDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-strategy", "MigrationHubStrategy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/get-recommendation-report-details/");
    try path_buf.appendSlice(allocator, input.id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRecommendationReportDetailsOutput {
    const result: GetRecommendationReportDetailsOutput = try aws.json.parseJsonObject(
        GetRecommendationReportDetailsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
