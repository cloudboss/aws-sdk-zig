const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalysisDetails = @import("analysis_details.zig").AnalysisDetails;
const AnalysisStatus = @import("analysis_status.zig").AnalysisStatus;
const CommitmentPurchaseAnalysisConfiguration = @import("commitment_purchase_analysis_configuration.zig").CommitmentPurchaseAnalysisConfiguration;
const ErrorCode = @import("error_code.zig").ErrorCode;

pub const GetCommitmentPurchaseAnalysisInput = struct {
    /// The analysis ID that's associated with the commitment purchase analysis.
    analysis_id: []const u8,

    pub const json_field_names = .{
        .analysis_id = "AnalysisId",
    };
};

pub const GetCommitmentPurchaseAnalysisOutput = struct {
    /// The completion time of the analysis.
    analysis_completion_time: ?[]const u8 = null,

    /// Details about the analysis.
    analysis_details: ?AnalysisDetails = null,

    /// The analysis ID that's associated with the commitment purchase analysis.
    analysis_id: []const u8,

    /// The start time of the analysis.
    analysis_started_time: []const u8,

    /// The status of the analysis.
    analysis_status: AnalysisStatus,

    /// The configuration for the commitment purchase analysis.
    commitment_purchase_analysis_configuration: ?CommitmentPurchaseAnalysisConfiguration = null,

    /// The error code used for the analysis.
    error_code: ?ErrorCode = null,

    /// The estimated time for when the analysis will complete.
    estimated_completion_time: []const u8,

    pub const json_field_names = .{
        .analysis_completion_time = "AnalysisCompletionTime",
        .analysis_details = "AnalysisDetails",
        .analysis_id = "AnalysisId",
        .analysis_started_time = "AnalysisStartedTime",
        .analysis_status = "AnalysisStatus",
        .commitment_purchase_analysis_configuration = "CommitmentPurchaseAnalysisConfiguration",
        .error_code = "ErrorCode",
        .estimated_completion_time = "EstimatedCompletionTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCommitmentPurchaseAnalysisInput, options: CallOptions) !GetCommitmentPurchaseAnalysisOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCommitmentPurchaseAnalysisInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetCommitmentPurchaseAnalysis");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCommitmentPurchaseAnalysisOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetCommitmentPurchaseAnalysisOutput, body, allocator);
}
