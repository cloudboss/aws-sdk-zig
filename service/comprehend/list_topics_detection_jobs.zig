const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TopicsDetectionJobFilter = @import("topics_detection_job_filter.zig").TopicsDetectionJobFilter;
const TopicsDetectionJobProperties = @import("topics_detection_job_properties.zig").TopicsDetectionJobProperties;

pub const ListTopicsDetectionJobsInput = struct {
    /// Filters the jobs that are returned. Jobs can be filtered on their name,
    /// status, or the
    /// date and time that they were submitted. You can set only one filter at a
    /// time.
    filter: ?TopicsDetectionJobFilter = null,

    /// The maximum number of results to return in each page. The default is 100.
    max_results: ?i32 = null,

    /// Identifies the next page of results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "Filter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListTopicsDetectionJobsOutput = struct {
    /// Identifies the next page of results to return.
    next_token: ?[]const u8 = null,

    /// A list containing the properties of each job that is returned.
    topics_detection_job_properties_list: ?[]const TopicsDetectionJobProperties = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .topics_detection_job_properties_list = "TopicsDetectionJobPropertiesList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTopicsDetectionJobsInput, options: CallOptions) !ListTopicsDetectionJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "comprehend", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTopicsDetectionJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("comprehend", "Comprehend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.ListTopicsDetectionJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTopicsDetectionJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTopicsDetectionJobsOutput, body, allocator);
}
