const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataQualityResultsV2FilterCriteria = @import("data_quality_results_v2_filter_criteria.zig").DataQualityResultsV2FilterCriteria;
const DataQualityResultsV2Description = @import("data_quality_results_v2_description.zig").DataQualityResultsV2Description;

pub const ListDataQualityResultsV2Input = struct {
    /// The filter criteria.
    filter: ?DataQualityResultsV2FilterCriteria = null,

    /// The maximum number of results to return. If you don't specify a value, the
    /// operation uses the default number of results.
    max_results: ?i32 = null,

    /// A pagination token to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "Filter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListDataQualityResultsV2Output = struct {
    /// A pagination token, if more results are available.
    next_token: ?[]const u8 = null,

    /// A list of `DataQualityResultsV2Description` objects.
    results: ?[]const DataQualityResultsV2Description = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .results = "Results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDataQualityResultsV2Input, options: CallOptions) !ListDataQualityResultsV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDataQualityResultsV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.ListDataQualityResultsV2");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDataQualityResultsV2Output {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListDataQualityResultsV2Output, body, allocator);
}
