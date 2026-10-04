const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobStatus = @import("job_status.zig").JobStatus;
const ImportJobProperties = @import("import_job_properties.zig").ImportJobProperties;

pub const ListFHIRImportJobsInput = struct {
    /// Limits the response to the import job with the specified data store ID.
    datastore_id: []const u8,

    /// Limits the response to the import job with the specified job name.
    job_name: ?[]const u8 = null,

    /// Limits the response to the import job with the specified job status.
    job_status: ?JobStatus = null,

    /// Limits the number of results returned for `ListFHIRImportJobs` to a maximum
    /// quantity specified by the user.
    max_results: ?i32 = null,

    /// The pagination token used to identify the next page of results to return.
    next_token: ?[]const u8 = null,

    /// Limits the response to FHIR import jobs submitted after a user-specified
    /// date.
    submitted_after: ?i64 = null,

    /// Limits the response to FHIR import jobs submitted before a user- specified
    /// date.
    submitted_before: ?i64 = null,

    pub const json_field_names = .{
        .datastore_id = "DatastoreId",
        .job_name = "JobName",
        .job_status = "JobStatus",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .submitted_after = "SubmittedAfter",
        .submitted_before = "SubmittedBefore",
    };
};

pub const ListFHIRImportJobsOutput = struct {
    /// The properties for listed import jobs.
    import_job_properties_list: ?[]const ImportJobProperties = null,

    /// The pagination token used to identify the next page of results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .import_job_properties_list = "ImportJobPropertiesList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFHIRImportJobsInput, options: CallOptions) !ListFHIRImportJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "healthlake", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFHIRImportJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("healthlake", "HealthLake", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "HealthLake.ListFHIRImportJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFHIRImportJobsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListFHIRImportJobsOutput, body, allocator);
}
