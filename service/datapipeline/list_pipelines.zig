const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PipelineIdName = @import("pipeline_id_name.zig").PipelineIdName;

pub const ListPipelinesInput = struct {
    /// The starting point for the results to be returned. For the first call, this
    /// value should be empty.
    /// As long as there are more results, continue to call `ListPipelines` with
    /// the marker value from the previous call to retrieve the next set of results.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .marker = "marker",
    };
};

pub const ListPipelinesOutput = struct {
    /// Indicates whether there are more results that can be obtained by a
    /// subsequent call.
    has_more_results: ?bool = null,

    /// The starting point for the next page of results. To view the next page of
    /// results, call `ListPipelinesOutput`
    /// again with this marker value. If the value is null, there are no more
    /// results.
    marker: ?[]const u8 = null,

    /// The pipeline identifiers. If you require additional information about the
    /// pipelines, you can use these identifiers to call
    /// DescribePipelines and GetPipelineDefinition.
    pipeline_id_list: ?[]const PipelineIdName = null,

    pub const json_field_names = .{
        .has_more_results = "hasMoreResults",
        .marker = "marker",
        .pipeline_id_list = "pipelineIdList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPipelinesInput, options: CallOptions) !ListPipelinesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPipelinesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DataPipeline.ListPipelines");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPipelinesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListPipelinesOutput, body, allocator);
}
