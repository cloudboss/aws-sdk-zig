const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListSourceViewsForBillingViewInput = struct {
    /// The Amazon Resource Name (ARN) that can be used to uniquely identify the
    /// billing view.
    arn: []const u8,

    /// The number of entries a paginated response contains.
    max_results: ?i32 = null,

    /// The pagination token that is used on subsequent calls to list billing views.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListSourceViewsForBillingViewOutput = struct {
    /// The pagination token that is used on subsequent calls to list billing views.
    next_token: ?[]const u8 = null,

    /// A list of billing views used as the data source for the custom billing view.
    source_views: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .source_views = "sourceViews",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSourceViewsForBillingViewInput, options: CallOptions) !ListSourceViewsForBillingViewOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "billing", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSourceViewsForBillingViewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billing", "Billing", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSBilling.ListSourceViewsForBillingView");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSourceViewsForBillingViewOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListSourceViewsForBillingViewOutput, body, allocator);
}
