const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationRecorderFilter = @import("configuration_recorder_filter.zig").ConfigurationRecorderFilter;
const ConfigurationRecorderSummary = @import("configuration_recorder_summary.zig").ConfigurationRecorderSummary;

pub const ListConfigurationRecordersInput = struct {
    /// Filters the results based on a list of `ConfigurationRecorderFilter` objects
    /// that you specify.
    filters: ?[]const ConfigurationRecorderFilter = null,

    /// The maximum number of results to include in the response.
    max_results: ?i32 = null,

    /// The `NextToken` string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListConfigurationRecordersOutput = struct {
    /// A list of `ConfigurationRecorderSummary` objects that includes.
    configuration_recorder_summaries: ?[]const ConfigurationRecorderSummary = null,

    /// The `NextToken` string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_recorder_summaries = "ConfigurationRecorderSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConfigurationRecordersInput, options: CallOptions) !ListConfigurationRecordersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConfigurationRecordersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.ListConfigurationRecorders");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConfigurationRecordersOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListConfigurationRecordersOutput, body, allocator);
}
