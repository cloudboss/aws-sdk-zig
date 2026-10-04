const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Currency = @import("currency.zig").Currency;
const MonetizationFilter = @import("monetization_filter.zig").MonetizationFilter;
const Scope = @import("scope.zig").Scope;
const TimeWindow = @import("time_window.zig").TimeWindow;
const RevenueBreakdown = @import("revenue_breakdown.zig").RevenueBreakdown;

pub const GetRevenueStatisticsSummaryInput = struct {
    /// The currency for the revenue amounts in the response. Currently only `USDC`
    /// is supported.
    currency: Currency,

    /// Optional filters to narrow the results. You can filter by source name,
    /// category, organization, intent, verified status, content path, web ACL ARN,
    /// or currency mode.
    filters: ?[]const MonetizationFilter = null,

    /// Specifies whether this is for a Amazon CloudFront distribution
    /// (`CLOUDFRONT`) or for a regional application (`REGIONAL`). AI bot
    /// monetization is only available for `CLOUDFRONT` scope.
    scope: Scope,

    /// The time range for the revenue summary query. Specify start and end
    /// timestamps.
    time_window: TimeWindow,

    pub const json_field_names = .{
        .currency = "Currency",
        .filters = "Filters",
        .scope = "Scope",
        .time_window = "TimeWindow",
    };
};

pub const GetRevenueStatisticsSummaryOutput = struct {
    /// The revenue breakdown summary for the specified time window and filters.
    revenue_breakdown: ?RevenueBreakdown = null,

    pub const json_field_names = .{
        .revenue_breakdown = "RevenueBreakdown",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRevenueStatisticsSummaryInput, options: CallOptions) !GetRevenueStatisticsSummaryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wafv2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRevenueStatisticsSummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wafv2", "WAFV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.GetRevenueStatisticsSummary");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRevenueStatisticsSummaryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRevenueStatisticsSummaryOutput, body, allocator);
}
