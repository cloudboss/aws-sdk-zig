const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TranscriptionJobStatus = @import("transcription_job_status.zig").TranscriptionJobStatus;
const MedicalTranscriptionJobSummary = @import("medical_transcription_job_summary.zig").MedicalTranscriptionJobSummary;

pub const ListMedicalTranscriptionJobsInput = struct {
    /// Returns only the medical transcription jobs that contain the specified
    /// string. The
    /// search is not case sensitive.
    job_name_contains: ?[]const u8 = null,

    /// The maximum number of medical transcription jobs to return in each page of
    /// results. If
    /// there are fewer results than the value that you specify, only the actual
    /// results are
    /// returned. If you do not specify a value, a default of 5 is used.
    max_results: ?i32 = null,

    /// If your `ListMedicalTranscriptionJobs` request returns more results than
    /// can be displayed, `NextToken` is displayed in the response with an
    /// associated
    /// string. To get the next page of results, copy this string and repeat your
    /// request,
    /// including `NextToken` with the value of the copied string. Repeat as needed
    /// to view all your results.
    next_token: ?[]const u8 = null,

    /// Returns only medical transcription jobs with the specified status. Jobs are
    /// ordered by
    /// creation date, with the newest job first. If you do not include `Status`,
    /// all
    /// medical transcription jobs are returned.
    status: ?TranscriptionJobStatus = null,

    pub const json_field_names = .{
        .job_name_contains = "JobNameContains",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub const ListMedicalTranscriptionJobsOutput = struct {
    /// Provides a summary of information about each result.
    medical_transcription_job_summaries: ?[]const MedicalTranscriptionJobSummary = null,

    /// If `NextToken` is present in your response, it indicates that not all
    /// results are displayed. To view the next set of results, copy the string
    /// associated with
    /// the `NextToken` parameter in your results output, then run your request
    /// again
    /// including `NextToken` with the value of the copied string. Repeat as needed
    /// to view all your results.
    next_token: ?[]const u8 = null,

    /// Lists all medical transcription jobs that have the status specified in your
    /// request.
    /// Jobs are ordered by creation date, with the newest job first.
    status: ?TranscriptionJobStatus = null,

    pub const json_field_names = .{
        .medical_transcription_job_summaries = "MedicalTranscriptionJobSummaries",
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMedicalTranscriptionJobsInput, options: CallOptions) !ListMedicalTranscriptionJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transcribe", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMedicalTranscriptionJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transcribe", "Transcribe", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Transcribe.ListMedicalTranscriptionJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMedicalTranscriptionJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListMedicalTranscriptionJobsOutput, body, allocator);
}
