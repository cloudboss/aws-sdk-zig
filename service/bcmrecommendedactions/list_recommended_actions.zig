const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RequestFilter = @import("request_filter.zig").RequestFilter;
const RecommendedAction = @import("recommended_action.zig").RecommendedAction;

pub const ListRecommendedActionsInput = struct {
    /// The criteria that you want all returned recommended actions to match.
    filter: ?RequestFilter = null,

    /// The maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// The pagination token that indicates the next set of results that you want to
    /// retrieve.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "filter",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListRecommendedActionsOutput = struct {
    /// The pagination token that indicates the next set of results that you want to
    /// retrieve.
    next_token: ?[]const u8 = null,

    /// The list of recommended actions that satisfy the filter criteria.
    recommended_actions: ?[]const RecommendedAction = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .recommended_actions = "recommendedActions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRecommendedActionsInput, options: CallOptions) !ListRecommendedActionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bcm-recommended-actions", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRecommendedActionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bcm-recommended-actions", "BCM Recommended Actions", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSBillingAndCostManagementRecommendedActions.ListRecommendedActions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRecommendedActionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListRecommendedActionsOutput, body, allocator);
}
