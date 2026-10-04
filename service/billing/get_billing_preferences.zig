const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BillingFeature = @import("billing_feature.zig").BillingFeature;
const BillingFeatureFilter = @import("billing_feature_filter.zig").BillingFeatureFilter;
const BillingPreferenceSummary = @import("billing_preference_summary.zig").BillingPreferenceSummary;

pub const GetBillingPreferencesInput = struct {
    /// The feature to retrieve. Specify exactly one value. Valid values:
    /// `BILLING_ALERTS`, `RI_SHARING`, `RI_SHARING_HISTORY`, `CREDIT_SHARING`,
    /// `CREDIT_SHARING_HISTORY`, `CREDIT_LEVEL_SHARING`,
    /// `CREDIT_PREFERENCE_OPTIONS`.
    features: []const BillingFeature,

    /// Filters to narrow results. Specify exactly one filter when supplied. The
    /// supported filter name is `PREFERENCE_KEY`, which accepts 1 to 10 values to
    /// match preference keys.
    filters: ?[]const BillingFeatureFilter = null,

    /// The maximum number of records to return per page. Range: 1 to 50. Default:
    /// 50.
    max_results: ?i32 = null,

    /// Pagination token from a previous response. Pass the value returned in
    /// `nextToken` to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .features = "features",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const GetBillingPreferencesOutput = struct {
    /// The list of preference entries matching the request.
    billing_preferences: ?[]const BillingPreferenceSummary = null,

    /// Pagination token. Present when more pages are available; `null` when there
    /// are no more results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .billing_preferences = "billingPreferences",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBillingPreferencesInput, options: CallOptions) !GetBillingPreferencesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBillingPreferencesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBilling.GetBillingPreferences");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBillingPreferencesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetBillingPreferencesOutput, body, allocator);
}
