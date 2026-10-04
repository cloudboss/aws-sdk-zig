const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListQueuesInput = struct {
    /// Maximum number of results to include in the response. Value range is 1 to
    /// 1000. You
    /// must set `MaxResults` to receive a value for `NextToken` in the
    /// response.
    max_results: ?i32 = null,

    /// Pagination token to request the next set of results.
    next_token: ?[]const u8 = null,

    /// A string to use for filtering the list results. Only those queues whose name
    /// begins
    /// with the specified string are returned.
    ///
    /// Queue URLs and names are case-sensitive.
    queue_name_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .queue_name_prefix = "QueueNamePrefix",
    };
};

pub const ListQueuesOutput = struct {
    /// Pagination token to include in the next request. Token value is `null` if
    /// there are no additional results to request, or if you did not set
    /// `MaxResults` in the request.
    next_token: ?[]const u8 = null,

    /// A list of queue URLs, up to 1,000 entries, or the value of `MaxResults`
    /// that you sent in the request.
    queue_urls: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .queue_urls = "QueueUrls",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListQueuesInput, options: CallOptions) !ListQueuesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sqs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListQueuesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sqs", "SQS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSQS.ListQueues");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListQueuesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListQueuesOutput, body, allocator);
}
