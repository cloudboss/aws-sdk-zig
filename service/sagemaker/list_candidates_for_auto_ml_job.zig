const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CandidateSortBy = @import("candidate_sort_by.zig").CandidateSortBy;
const AutoMLSortOrder = @import("auto_ml_sort_order.zig").AutoMLSortOrder;
const CandidateStatus = @import("candidate_status.zig").CandidateStatus;
const AutoMLCandidate = @import("auto_ml_candidate.zig").AutoMLCandidate;

pub const ListCandidatesForAutoMLJobInput = struct {
    /// List the candidates created for the job by providing the job's name.
    auto_ml_job_name: []const u8,

    /// List the candidates for the job and filter by candidate name.
    candidate_name_equals: ?[]const u8 = null,

    /// List the job's candidates up to a specified limit.
    max_results: ?i32 = null,

    /// If the previous response was truncated, you receive this token. Use it in
    /// your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// The parameter by which to sort the results. The default is `Descending`.
    sort_by: ?CandidateSortBy = null,

    /// The sort order for the results. The default is `Ascending`.
    sort_order: ?AutoMLSortOrder = null,

    /// List the candidates for the job and filter by status.
    status_equals: ?CandidateStatus = null,

    pub const json_field_names = .{
        .auto_ml_job_name = "AutoMLJobName",
        .candidate_name_equals = "CandidateNameEquals",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status_equals = "StatusEquals",
    };
};

pub const ListCandidatesForAutoMLJobOutput = struct {
    /// Summaries about the `AutoMLCandidates`.
    candidates: ?[]const AutoMLCandidate = null,

    /// If the previous response was truncated, you receive this token. Use it in
    /// your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .candidates = "Candidates",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCandidatesForAutoMLJobInput, options: CallOptions) !ListCandidatesForAutoMLJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCandidatesForAutoMLJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListCandidatesForAutoMLJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCandidatesForAutoMLJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListCandidatesForAutoMLJobOutput, body, allocator);
}
