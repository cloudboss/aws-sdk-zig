const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MediaAnalysisJobDescription = @import("media_analysis_job_description.zig").MediaAnalysisJobDescription;

pub const ListMediaAnalysisJobsInput = struct {
    /// The maximum number of results to return per paginated call. The largest
    /// value user can specify is 100.
    /// If user specifies a value greater than 100, an `InvalidParameterException`
    /// error occurs. The default value is 100.
    max_results: ?i32 = null,

    /// Pagination token, if the previous response was incomplete.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListMediaAnalysisJobsOutput = struct {
    /// Contains a list of all media analysis jobs.
    media_analysis_jobs: ?[]const MediaAnalysisJobDescription = null,

    /// Pagination token, if the previous response was incomplete.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .media_analysis_jobs = "MediaAnalysisJobs",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMediaAnalysisJobsInput, options: CallOptions) !ListMediaAnalysisJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rekognition", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMediaAnalysisJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rekognition", "Rekognition", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.ListMediaAnalysisJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMediaAnalysisJobsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListMediaAnalysisJobsOutput, body, allocator);
}
