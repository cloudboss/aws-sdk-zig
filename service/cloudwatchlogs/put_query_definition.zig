const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryParameter = @import("query_parameter.zig").QueryParameter;
const QueryLanguage = @import("query_language.zig").QueryLanguage;

pub const PutQueryDefinitionInput = struct {
    /// Used as an idempotency token, to avoid returning an exception if the service
    /// receives the
    /// same request twice because of a network error.
    client_token: ?[]const u8 = null,

    /// Use this parameter to include specific log groups as part of your query
    /// definition. If
    /// your query uses the OpenSearch Service query language, you specify the log
    /// group names inside
    /// the `querystring` instead of here.
    ///
    /// If you are updating an existing query definition for the Logs Insights QL or
    /// OpenSearch Service PPL and you omit this parameter, then the updated
    /// definition will contain no log
    /// groups.
    log_group_names: ?[]const []const u8 = null,

    /// A name for the query definition. If you are saving numerous query
    /// definitions, we
    /// recommend that you name them. This way, you can find the ones you want by
    /// using the first part
    /// of the name as a filter in the `queryDefinitionNamePrefix` parameter of
    /// [DescribeQueryDefinitions](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DescribeQueryDefinitions.html).
    name: []const u8,

    /// Use this parameter to include specific query parameters as part of your
    /// query definition.
    /// Query parameters are supported only for Logs Insights QL queries. Query
    /// parameters allow you
    /// to use placeholder variables in your query string that are substituted with
    /// values at execution
    /// time. Use the `{{parameterName}}` syntax in your query string to reference a
    /// parameter.
    parameters: ?[]const QueryParameter = null,

    /// If you are updating a query definition, use this parameter to specify the ID
    /// of the query
    /// definition that you want to update. You can use
    /// [DescribeQueryDefinitions](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DescribeQueryDefinitions.html) to retrieve the IDs of your saved query
    /// definitions.
    ///
    /// If you are creating a query definition, do not specify this parameter.
    /// CloudWatch
    /// generates a unique ID for the new query definition and include it in the
    /// response to this
    /// operation.
    query_definition_id: ?[]const u8 = null,

    /// Specify the query language to use for this query. The options are Logs
    /// Insights QL,
    /// OpenSearch PPL, and OpenSearch SQL. For more information about the query
    /// languages that
    /// CloudWatch Logs supports, see [Supported query
    /// languages](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_AnalyzeLogData_Languages.html).
    query_language: ?QueryLanguage = null,

    /// The query string to use for this definition. For more information, see
    /// [CloudWatch Logs
    /// Insights Query
    /// Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html).
    query_string: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .log_group_names = "logGroupNames",
        .name = "name",
        .parameters = "parameters",
        .query_definition_id = "queryDefinitionId",
        .query_language = "queryLanguage",
        .query_string = "queryString",
    };
};

pub const PutQueryDefinitionOutput = struct {
    /// The ID of the query definition.
    query_definition_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .query_definition_id = "queryDefinitionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutQueryDefinitionInput, options: CallOptions) !PutQueryDefinitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutQueryDefinitionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.PutQueryDefinition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutQueryDefinitionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutQueryDefinitionOutput, body, allocator);
}
