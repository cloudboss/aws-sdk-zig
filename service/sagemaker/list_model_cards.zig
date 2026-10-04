const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ModelCardStatus = @import("model_card_status.zig").ModelCardStatus;
const ModelCardSortBy = @import("model_card_sort_by.zig").ModelCardSortBy;
const ModelCardSortOrder = @import("model_card_sort_order.zig").ModelCardSortOrder;
const ModelCardSummary = @import("model_card_summary.zig").ModelCardSummary;

pub const ListModelCardsInput = struct {
    /// Only list model cards that were created after the time specified.
    creation_time_after: ?i64 = null,

    /// Only list model cards that were created before the time specified.
    creation_time_before: ?i64 = null,

    /// The maximum number of model cards to list.
    max_results: ?i32 = null,

    /// Only list model cards with the specified approval status.
    model_card_status: ?ModelCardStatus = null,

    /// Only list model cards with names that contain the specified string.
    name_contains: ?[]const u8 = null,

    /// If the response to a previous `ListModelCards` request was truncated, the
    /// response includes a `NextToken`. To retrieve the next set of model cards,
    /// use the token in the next request.
    next_token: ?[]const u8 = null,

    /// Sort model cards by either name or creation time. Sorts by creation time by
    /// default.
    sort_by: ?ModelCardSortBy = null,

    /// Sort model cards by ascending or descending order.
    sort_order: ?ModelCardSortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .max_results = "MaxResults",
        .model_card_status = "ModelCardStatus",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListModelCardsOutput = struct {
    /// The summaries of the listed model cards.
    model_card_summaries: ?[]const ModelCardSummary = null,

    /// If the response is truncated, SageMaker returns this token. To retrieve the
    /// next set of model cards, use it in the subsequent request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_card_summaries = "ModelCardSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListModelCardsInput, options: CallOptions) !ListModelCardsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListModelCardsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListModelCards");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListModelCardsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListModelCardsOutput, body, allocator);
}
