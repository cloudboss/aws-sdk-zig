const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TextTranslationJobFilter = @import("text_translation_job_filter.zig").TextTranslationJobFilter;
const TextTranslationJobProperties = @import("text_translation_job_properties.zig").TextTranslationJobProperties;

pub const ListTextTranslationJobsInput = struct {
    /// The parameters that specify which batch translation jobs to retrieve.
    /// Filters include job
    /// name, job status, and submission time. You can only set one filter at a
    /// time.
    filter: ?TextTranslationJobFilter = null,

    /// The maximum number of results to return in each page. The default value is
    /// 100.
    max_results: ?i32 = null,

    /// The token to request the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "Filter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListTextTranslationJobsOutput = struct {
    /// The token to use to retrieve the next page of results. This value is `null`
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// A list containing the properties of each job that is returned.
    text_translation_job_properties_list: ?[]const TextTranslationJobProperties = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .text_translation_job_properties_list = "TextTranslationJobPropertiesList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTextTranslationJobsInput, options: CallOptions) !ListTextTranslationJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "translate", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTextTranslationJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("translate", "Translate", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSShineFrontendService_20170701.ListTextTranslationJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTextTranslationJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTextTranslationJobsOutput, body, allocator);
}
