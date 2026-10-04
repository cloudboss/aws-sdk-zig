const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComprehendMedicalAsyncJobFilter = @import("comprehend_medical_async_job_filter.zig").ComprehendMedicalAsyncJobFilter;
const ComprehendMedicalAsyncJobProperties = @import("comprehend_medical_async_job_properties.zig").ComprehendMedicalAsyncJobProperties;

pub const ListRxNormInferenceJobsInput = struct {
    /// Filters the jobs that are returned. You can filter jobs based on their
    /// names, status, or
    /// the date and time that they were submitted. You can only set one filter at a
    /// time.
    filter: ?ComprehendMedicalAsyncJobFilter = null,

    /// Identifies the next page of results to return.
    max_results: ?i32 = null,

    /// Identifies the next page of results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "Filter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListRxNormInferenceJobsOutput = struct {
    /// The maximum number of results to return in each page. The default is 100.
    comprehend_medical_async_job_properties_list: ?[]const ComprehendMedicalAsyncJobProperties = null,

    /// Identifies the next page of results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .comprehend_medical_async_job_properties_list = "ComprehendMedicalAsyncJobPropertiesList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRxNormInferenceJobsInput, options: CallOptions) !ListRxNormInferenceJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "comprehendmedical", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRxNormInferenceJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("comprehendmedical", "ComprehendMedical", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ComprehendMedical_20181030.ListRxNormInferenceJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRxNormInferenceJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListRxNormInferenceJobsOutput, body, allocator);
}
