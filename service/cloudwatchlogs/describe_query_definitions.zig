const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryLanguage = @import("query_language.zig").QueryLanguage;
const QueryDefinition = @import("query_definition.zig").QueryDefinition;

pub const DescribeQueryDefinitionsInput = struct {
    /// Limits the number of returned query definitions to the specified number.
    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    /// Use this parameter to filter your results to only the query definitions that
    /// have names
    /// that start with the prefix you specify.
    query_definition_name_prefix: ?[]const u8 = null,

    /// The query language used for this query. For more information about the query
    /// languages
    /// that CloudWatch Logs supports, see [Supported query
    /// languages](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_AnalyzeLogData_Languages.html).
    query_language: ?QueryLanguage = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .query_definition_name_prefix = "queryDefinitionNamePrefix",
        .query_language = "queryLanguage",
    };
};

pub const DescribeQueryDefinitionsOutput = struct {
    next_token: ?[]const u8 = null,

    /// The list of query definitions that match your request.
    query_definitions: ?[]const QueryDefinition = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .query_definitions = "queryDefinitions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeQueryDefinitionsInput, options: CallOptions) !DescribeQueryDefinitionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeQueryDefinitionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.DescribeQueryDefinitions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeQueryDefinitionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeQueryDefinitionsOutput, body, allocator);
}
