const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Currency = @import("currency.zig").Currency;
const MonetizationFilter = @import("monetization_filter.zig").MonetizationFilter;
const Scope = @import("scope.zig").Scope;
const SettlementSortBy = @import("settlement_sort_by.zig").SettlementSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const TimeWindow = @import("time_window.zig").TimeWindow;
const SettlementRecord = @import("settlement_record.zig").SettlementRecord;

pub const ListSettlementRecordsInput = struct {
    /// The currency for the amounts in the response.
    currency: Currency,

    /// Optional filters to narrow the results. You can filter by payer address,
    /// status, source name, network, or other settlement fields.
    filters: ?[]const MonetizationFilter = null,

    /// The maximum number of settlement records to return. Minimum: 1. Maximum:
    /// 100.
    limit: ?i32 = null,

    /// When you get a paginated response, this marker indicates that additional
    /// results are available.
    next_marker: ?[]const u8 = null,

    /// Specifies whether this is for a Amazon CloudFront distribution
    /// (`CLOUDFRONT`) or for a regional application (`REGIONAL`).
    scope: Scope,

    /// The field to sort settlement records by: `TIMESTAMP`, `AMOUNT`, `NAME`, or
    /// `STATUS`.
    sort_by: ?SettlementSortBy = null,

    /// The sort order: `ASC` for ascending or `DESC` for descending.
    sort_order: ?SortOrder = null,

    /// The time range for the query. Specify start and end timestamps.
    time_window: TimeWindow,

    pub const json_field_names = .{
        .currency = "Currency",
        .filters = "Filters",
        .limit = "Limit",
        .next_marker = "NextMarker",
        .scope = "Scope",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .time_window = "TimeWindow",
    };
};

pub const ListSettlementRecordsOutput = struct {
    /// When you get a paginated response, this marker indicates that additional
    /// results are available.
    next_marker: ?[]const u8 = null,

    /// The list of settlement records.
    settlements: ?[]const SettlementRecord = null,

    pub const json_field_names = .{
        .next_marker = "NextMarker",
        .settlements = "Settlements",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSettlementRecordsInput, options: CallOptions) !ListSettlementRecordsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSettlementRecordsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.ListSettlementRecords");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSettlementRecordsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListSettlementRecordsOutput, body, allocator);
}
