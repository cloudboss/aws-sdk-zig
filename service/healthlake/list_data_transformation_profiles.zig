const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SourceFormat = @import("source_format.zig").SourceFormat;
const DataTransformationProfileSummary = @import("data_transformation_profile_summary.zig").DataTransformationProfileSummary;

pub const ListDataTransformationProfilesInput = struct {
    /// The maximum number of profiles to return per page. If you don't specify a
    /// value, the service returns up to 100 results.
    max_results: ?i32 = null,

    /// The pagination token from a previous response. Pass this value to retrieve
    /// the next page of results.
    next_token: ?[]const u8 = null,

    /// Filters the results by source data format.
    source_format: SourceFormat,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .source_format = "SourceFormat",
    };
};

pub const ListDataTransformationProfilesOutput = struct {
    /// The list of data transformation profile summaries.
    items: ?[]const DataTransformationProfileSummary = null,

    /// The pagination token to use in the next request. If this value is `null`,
    /// there are no more results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDataTransformationProfilesInput, options: CallOptions) !ListDataTransformationProfilesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDataTransformationProfilesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "HealthLake.ListDataTransformationProfiles");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDataTransformationProfilesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListDataTransformationProfilesOutput, body, allocator);
}
