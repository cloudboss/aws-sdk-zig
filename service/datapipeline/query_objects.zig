const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Query = @import("query.zig").Query;

pub const QueryObjectsInput = struct {
    /// The maximum number of object names that `QueryObjects` will return in a
    /// single call. The default value is 100.
    limit: ?i32 = null,

    /// The starting point for the results to be returned. For the first call, this
    /// value should be empty.
    /// As long as there are more results, continue to call `QueryObjects` with
    /// the marker value from the previous call to retrieve the next set of results.
    marker: ?[]const u8 = null,

    /// The ID of the pipeline.
    pipeline_id: []const u8,

    /// The query that defines the objects to be returned. The `Query` object can
    /// contain a maximum of ten selectors.
    /// The conditions in the query are limited to top-level String fields in the
    /// object.
    /// These filters can be applied to components, instances, and attempts.
    query: ?Query = null,

    /// Indicates whether the query applies to components or instances. The possible
    /// values are:
    /// `COMPONENT`, `INSTANCE`, and `ATTEMPT`.
    sphere: []const u8,

    pub const json_field_names = .{
        .limit = "limit",
        .marker = "marker",
        .pipeline_id = "pipelineId",
        .query = "query",
        .sphere = "sphere",
    };
};

pub const QueryObjectsOutput = struct {
    /// Indicates whether there are more results that can be obtained by a
    /// subsequent call.
    has_more_results: ?bool = null,

    /// The identifiers that match the query selectors.
    ids: ?[]const []const u8 = null,

    /// The starting point for the next page of results. To view the next page of
    /// results, call `QueryObjects`
    /// again with this marker value. If the value is null, there are no more
    /// results.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .has_more_results = "hasMoreResults",
        .ids = "ids",
        .marker = "marker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: QueryObjectsInput, options: CallOptions) !QueryObjectsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datapipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: QueryObjectsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datapipeline", "Data Pipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DataPipeline.QueryObjects");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !QueryObjectsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(QueryObjectsOutput, body, allocator);
}
