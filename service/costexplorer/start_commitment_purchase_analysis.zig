const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CommitmentPurchaseAnalysisConfiguration = @import("commitment_purchase_analysis_configuration.zig").CommitmentPurchaseAnalysisConfiguration;

pub const StartCommitmentPurchaseAnalysisInput = struct {
    /// The configuration for the commitment purchase analysis.
    commitment_purchase_analysis_configuration: CommitmentPurchaseAnalysisConfiguration,

    pub const json_field_names = .{
        .commitment_purchase_analysis_configuration = "CommitmentPurchaseAnalysisConfiguration",
    };
};

pub const StartCommitmentPurchaseAnalysisOutput = struct {
    /// The analysis ID that's associated with the commitment purchase analysis.
    analysis_id: []const u8,

    /// The start time of the analysis.
    analysis_started_time: []const u8,

    /// The estimated time for when the analysis will complete.
    estimated_completion_time: []const u8,

    pub const json_field_names = .{
        .analysis_id = "AnalysisId",
        .analysis_started_time = "AnalysisStartedTime",
        .estimated_completion_time = "EstimatedCompletionTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartCommitmentPurchaseAnalysisInput, options: CallOptions) !StartCommitmentPurchaseAnalysisOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartCommitmentPurchaseAnalysisInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.StartCommitmentPurchaseAnalysis");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartCommitmentPurchaseAnalysisOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartCommitmentPurchaseAnalysisOutput, body, allocator);
}
