const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryGenerationInput = @import("query_generation_input.zig").QueryGenerationInput;
const TransformationConfiguration = @import("transformation_configuration.zig").TransformationConfiguration;
const GeneratedQuery = @import("generated_query.zig").GeneratedQuery;

pub const GenerateQueryInput = struct {
    /// Specifies information about a natural language query to transform into SQL.
    query_generation_input: QueryGenerationInput,

    /// Specifies configurations for transforming the natural language query into
    /// SQL.
    transformation_configuration: TransformationConfiguration,

    pub const json_field_names = .{
        .query_generation_input = "queryGenerationInput",
        .transformation_configuration = "transformationConfiguration",
    };
};

pub const GenerateQueryOutput = struct {
    /// A list of objects, each of which defines a generated query that can
    /// correspond to the natural language queries.
    queries: ?[]const GeneratedQuery = null,

    pub const json_field_names = .{
        .queries = "queries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateQueryInput, options: CallOptions) !GenerateQueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent-runtime", "Bedrock Agent Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/generateQuery";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"queryGenerationInput\":");
    try aws.json.writeValue(@TypeOf(input.query_generation_input), input.query_generation_input, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"transformationConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.transformation_configuration), input.transformation_configuration, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateQueryOutput {
    var result: GenerateQueryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GenerateQueryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
