const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceRequestStatusFilter = @import("resource_request_status_filter.zig").ResourceRequestStatusFilter;
const ProgressEvent = @import("progress_event.zig").ProgressEvent;

pub const ListResourceRequestsInput = struct {
    /// The maximum number of results to be returned with a single call. If the
    /// number of
    /// available results exceeds this maximum, the response includes a `NextToken`
    /// value
    /// that you can assign to the `NextToken` request parameter to get the next set
    /// of
    /// results.
    ///
    /// The default is `20`.
    max_results: ?i32 = null,

    /// If the previous paginated request didn't return all of the remaining
    /// results,
    /// the response object's `NextToken` parameter value is set to a token.
    /// To retrieve the next set of results, call this action again and assign that
    /// token to
    /// the request object's `NextToken` parameter. If there are no remaining
    /// results, the previous response object's `NextToken` parameter is set to
    /// `null`.
    next_token: ?[]const u8 = null,

    /// The filter criteria to apply to the requests returned.
    resource_request_status_filter: ?ResourceRequestStatusFilter = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_request_status_filter = "ResourceRequestStatusFilter",
    };
};

pub const ListResourceRequestsOutput = struct {
    /// If the request doesn't return all of the remaining results,
    /// `NextToken` is set to a token. To retrieve the next set of results, call
    /// `ListResources` again and assign that token to the request object's
    /// `NextToken` parameter. If the request returns all results,
    /// `NextToken` is set to null.
    next_token: ?[]const u8 = null,

    /// The requests that match the specified filter criteria.
    resource_request_status_summaries: ?[]const ProgressEvent = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_request_status_summaries = "ResourceRequestStatusSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourceRequestsInput, options: CallOptions) !ListResourceRequestsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudapiservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourceRequestsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudcontrolapi", "CloudControl", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CloudApiService.ListResourceRequests");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourceRequestsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListResourceRequestsOutput, body, allocator);
}
