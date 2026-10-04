const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalysisStatus = @import("analysis_status.zig").AnalysisStatus;
const AnalysisSummary = @import("analysis_summary.zig").AnalysisSummary;

pub const ListCommitmentPurchaseAnalysesInput = struct {
    /// The analysis IDs associated with the commitment purchase analyses.
    analysis_ids: ?[]const []const u8 = null,

    /// The status of the analysis.
    analysis_status: ?AnalysisStatus = null,

    /// The token to retrieve the next set of results.
    next_page_token: ?[]const u8 = null,

    /// The number of analyses that you want returned in a single response object.
    page_size: ?i32 = null,

    pub const json_field_names = .{
        .analysis_ids = "AnalysisIds",
        .analysis_status = "AnalysisStatus",
        .next_page_token = "NextPageToken",
        .page_size = "PageSize",
    };
};

pub const ListCommitmentPurchaseAnalysesOutput = struct {
    /// The list of analyses.
    analysis_summary_list: ?[]const AnalysisSummary = null,

    /// The token to retrieve the next set of results.
    next_page_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .analysis_summary_list = "AnalysisSummaryList",
        .next_page_token = "NextPageToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCommitmentPurchaseAnalysesInput, options: CallOptions) !ListCommitmentPurchaseAnalysesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCommitmentPurchaseAnalysesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.ListCommitmentPurchaseAnalyses");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCommitmentPurchaseAnalysesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListCommitmentPurchaseAnalysesOutput, body, allocator);
}
