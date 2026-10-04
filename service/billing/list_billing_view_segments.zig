const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BillingViewSegmentTimeRange = @import("billing_view_segment_time_range.zig").BillingViewSegmentTimeRange;
const BillingViewSegmentsListElement = @import("billing_view_segments_list_element.zig").BillingViewSegmentsListElement;

pub const ListBillingViewSegmentsInput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the billing view to
    /// query. If you don't provide an ARN, the caller's `PRIMARY` billing view is
    /// used. The ARN must reference a primary billing view. Custom billing views
    /// aren't supported.
    arn: ?[]const u8 = null,

    /// The number of entries a paginated response contains. Valid values range from
    /// 1 to 100. The default is 100.
    max_results: ?i32 = null,

    /// The pagination token that is used on subsequent calls to list billing view
    /// segments.
    next_token: ?[]const u8 = null,

    /// The billing period to query. If you don't provide a time range, the current
    /// billing period, which is the calendar month in UTC, is used.
    time_range: ?BillingViewSegmentTimeRange = null,

    pub const json_field_names = .{
        .arn = "arn",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .time_range = "timeRange",
    };
};

pub const ListBillingViewSegmentsOutput = struct {
    /// A list of billing view segments. Each segment covers a portion of the
    /// requested time period. The response omits hidden segments, so the segments
    /// it returns might not cover the entire requested time period.
    items: ?[]const BillingViewSegmentsListElement = null,

    /// The pagination token that is used on subsequent calls to list billing view
    /// segments.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBillingViewSegmentsInput, options: CallOptions) !ListBillingViewSegmentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBillingViewSegmentsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBilling.ListBillingViewSegments");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBillingViewSegmentsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListBillingViewSegmentsOutput, body, allocator);
}
