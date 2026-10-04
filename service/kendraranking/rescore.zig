const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Document = @import("document.zig").Document;
const RescoreResultItem = @import("rescore_result_item.zig").RescoreResultItem;

pub const RescoreInput = struct {
    /// The list of documents for Amazon Kendra Intelligent
    /// Ranking to rescore or rank on.
    documents: []const Document,

    /// The identifier of the rescore execution plan. A rescore
    /// execution plan is an Amazon Kendra Intelligent Ranking
    /// resource used for provisioning the `Rescore` API.
    rescore_execution_plan_id: []const u8,

    /// The input query from the search service.
    search_query: []const u8,

    pub const json_field_names = .{
        .documents = "Documents",
        .rescore_execution_plan_id = "RescoreExecutionPlanId",
        .search_query = "SearchQuery",
    };
};

pub const RescoreOutput = struct {
    /// The identifier associated with the scores that
    /// Amazon Kendra Intelligent Ranking gives to the
    /// results. Amazon Kendra Intelligent Ranking
    /// rescores or re-ranks the results for the search service.
    rescore_id: ?[]const u8 = null,

    /// A list of result items for documents with new relevancy
    /// scores. The results are in descending order.
    result_items: ?[]const RescoreResultItem = null,

    pub const json_field_names = .{
        .rescore_id = "RescoreId",
        .result_items = "ResultItems",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RescoreInput, options: CallOptions) !RescoreOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra-ranking", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RescoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra-ranking", "Kendra Ranking", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraRerankingFrontendService.Rescore");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RescoreOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RescoreOutput, body, allocator);
}
