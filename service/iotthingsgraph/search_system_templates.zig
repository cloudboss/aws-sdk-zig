const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SystemTemplateFilter = @import("system_template_filter.zig").SystemTemplateFilter;
const SystemTemplateSummary = @import("system_template_summary.zig").SystemTemplateSummary;

pub const SearchSystemTemplatesInput = struct {
    /// An array of filters that limit the result set. The only valid filter is
    /// `FLOW_TEMPLATE_ID`.
    filters: ?[]const SystemTemplateFilter = null,

    /// The maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// The string that specifies the next page of results. Use this when you're
    /// paginating results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const SearchSystemTemplatesOutput = struct {
    /// The string to specify as `nextToken` when you request the next page of
    /// results.
    next_token: ?[]const u8 = null,

    /// An array of objects that contain summary information about each system
    /// deployment in the result set.
    summaries: ?[]const SystemTemplateSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .summaries = "summaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchSystemTemplatesInput, options: CallOptions) !SearchSystemTemplatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotthingsgraph", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchSystemTemplatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotthingsgraph", "IoTThingsGraph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "IotThingsGraphFrontEndService.SearchSystemTemplates");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchSystemTemplatesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SearchSystemTemplatesOutput, body, allocator);
}
