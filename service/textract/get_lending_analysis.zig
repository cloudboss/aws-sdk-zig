const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DocumentMetadata = @import("document_metadata.zig").DocumentMetadata;
const JobStatus = @import("job_status.zig").JobStatus;
const LendingResult = @import("lending_result.zig").LendingResult;
const Warning = @import("warning.zig").Warning;

pub const GetLendingAnalysisInput = struct {
    /// A unique identifier for the lending or text-detection job. The `JobId` is
    /// returned from `StartLendingAnalysis`. A `JobId` value is only
    /// valid for 7 days.
    job_id: []const u8,

    /// The maximum number of results to return per paginated call. The largest
    /// value that you
    /// can specify is 30. If you specify a value greater than 30, a maximum of 30
    /// results is
    /// returned. The default value is 30.
    max_results: ?i32 = null,

    /// If the previous response was incomplete, Amazon Textract returns a
    /// pagination token in
    /// the response. You can use this pagination token to retrieve the next set of
    /// lending
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_id = "JobId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const GetLendingAnalysisOutput = struct {
    /// The current model version of the Analyze Lending API.
    analyze_lending_model_version: ?[]const u8 = null,

    document_metadata: ?DocumentMetadata = null,

    /// The current status of the lending analysis job.
    job_status: ?JobStatus = null,

    /// If the response is truncated, Amazon Textract returns this token.
    /// You can use this token in the subsequent request to retrieve the next set of
    /// lending results.
    next_token: ?[]const u8 = null,

    /// Holds the information returned by one of AmazonTextract's document analysis
    /// operations for the pinstripe.
    results: ?[]const LendingResult = null,

    /// Returns if the lending analysis job could not be completed. Contains
    /// explanation for
    /// what error occurred.
    status_message: ?[]const u8 = null,

    /// A list of warnings that occurred during the lending analysis operation.
    warnings: ?[]const Warning = null,

    pub const json_field_names = .{
        .analyze_lending_model_version = "AnalyzeLendingModelVersion",
        .document_metadata = "DocumentMetadata",
        .job_status = "JobStatus",
        .next_token = "NextToken",
        .results = "Results",
        .status_message = "StatusMessage",
        .warnings = "Warnings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLendingAnalysisInput, options: CallOptions) !GetLendingAnalysisOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLendingAnalysisInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Textract.GetLendingAnalysis");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLendingAnalysisOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetLendingAnalysisOutput, body, allocator);
}
