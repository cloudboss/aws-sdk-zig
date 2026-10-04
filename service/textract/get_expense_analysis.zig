const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DocumentMetadata = @import("document_metadata.zig").DocumentMetadata;
const ExpenseDocument = @import("expense_document.zig").ExpenseDocument;
const JobStatus = @import("job_status.zig").JobStatus;
const Warning = @import("warning.zig").Warning;

pub const GetExpenseAnalysisInput = struct {
    /// A unique identifier for the text detection job. The `JobId` is returned from
    /// `StartExpenseAnalysis`. A `JobId` value is only valid for 7 days.
    job_id: []const u8,

    /// The maximum number of results to return per paginated call. The largest
    /// value you can
    /// specify is 20. If you specify a value greater than 20, a maximum of 20
    /// results is
    /// returned. The default value is 20.
    max_results: ?i32 = null,

    /// If the previous response was incomplete (because there are more blocks to
    /// retrieve), Amazon Textract returns a pagination
    /// token in the response. You can use this pagination token to retrieve the
    /// next set of blocks.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_id = "JobId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const GetExpenseAnalysisOutput = struct {
    /// The current model version of AnalyzeExpense.
    analyze_expense_model_version: ?[]const u8 = null,

    /// Information about a document that Amazon Textract processed.
    /// `DocumentMetadata` is
    /// returned in every page of paginated responses from an Amazon Textract
    /// operation.
    document_metadata: ?DocumentMetadata = null,

    /// The expenses detected by Amazon Textract.
    expense_documents: ?[]const ExpenseDocument = null,

    /// The current status of the text detection job.
    job_status: ?JobStatus = null,

    /// If the response is truncated, Amazon Textract returns this token. You can
    /// use this token in
    /// the subsequent request to retrieve the next set of text-detection results.
    next_token: ?[]const u8 = null,

    /// Returns if the detection job could not be completed. Contains explanation
    /// for what error occured.
    status_message: ?[]const u8 = null,

    /// A list of warnings that occurred during the text-detection operation for the
    /// document.
    warnings: ?[]const Warning = null,

    pub const json_field_names = .{
        .analyze_expense_model_version = "AnalyzeExpenseModelVersion",
        .document_metadata = "DocumentMetadata",
        .expense_documents = "ExpenseDocuments",
        .job_status = "JobStatus",
        .next_token = "NextToken",
        .status_message = "StatusMessage",
        .warnings = "Warnings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetExpenseAnalysisInput, options: CallOptions) !GetExpenseAnalysisOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetExpenseAnalysisInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Textract.GetExpenseAnalysis");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetExpenseAnalysisOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetExpenseAnalysisOutput, body, allocator);
}
