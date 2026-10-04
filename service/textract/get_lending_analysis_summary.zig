const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DocumentMetadata = @import("document_metadata.zig").DocumentMetadata;
const JobStatus = @import("job_status.zig").JobStatus;
const LendingSummary = @import("lending_summary.zig").LendingSummary;
const Warning = @import("warning.zig").Warning;

pub const GetLendingAnalysisSummaryInput = struct {
    /// A unique identifier for the lending or text-detection job. The `JobId` is
    /// returned from StartLendingAnalysis. A `JobId` value is only valid for 7
    /// days.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub const GetLendingAnalysisSummaryOutput = struct {
    /// The current model version of the Analyze Lending API.
    analyze_lending_model_version: ?[]const u8 = null,

    document_metadata: ?DocumentMetadata = null,

    /// The current status of the lending analysis job.
    job_status: ?JobStatus = null,

    /// Returns if the lending analysis could not be completed. Contains explanation
    /// for what error
    /// occurred.
    status_message: ?[]const u8 = null,

    /// Contains summary information for documents grouped by type.
    summary: ?LendingSummary = null,

    /// A list of warnings that occurred during the lending analysis operation.
    warnings: ?[]const Warning = null,

    pub const json_field_names = .{
        .analyze_lending_model_version = "AnalyzeLendingModelVersion",
        .document_metadata = "DocumentMetadata",
        .job_status = "JobStatus",
        .status_message = "StatusMessage",
        .summary = "Summary",
        .warnings = "Warnings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLendingAnalysisSummaryInput, options: CallOptions) !GetLendingAnalysisSummaryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "textract", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLendingAnalysisSummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("textract", "Textract", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Textract.GetLendingAnalysisSummary");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLendingAnalysisSummaryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetLendingAnalysisSummaryOutput, body, allocator);
}
