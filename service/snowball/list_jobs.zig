const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobListEntry = @import("job_list_entry.zig").JobListEntry;

pub const ListJobsInput = struct {
    /// The number of `JobListEntry` objects to return.
    max_results: ?i32 = null,

    /// HTTP requests are stateless. To identify what object comes "next" in the
    /// list of
    /// `JobListEntry` objects, you have the option of specifying `NextToken`
    /// as the starting point for your returned list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListJobsOutput = struct {
    /// Each `JobListEntry` object contains a job's state, a job's ID, and a value
    /// that indicates whether the job is a job part, in the case of export jobs.
    job_list_entries: ?[]const JobListEntry = null,

    /// HTTP requests are stateless. If you use this automatically generated
    /// `NextToken` value in your next `ListJobs` call, your returned
    /// `JobListEntry` objects will start from this point in the array.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_list_entries = "JobListEntries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListJobsInput, options: CallOptions) !ListJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "snowball", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("snowball", "Snowball", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSIESnowballJobManagementService.ListJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListJobsOutput, body, allocator);
}
