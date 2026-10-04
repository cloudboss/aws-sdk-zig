const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BillingPreferenceForKey = @import("billing_preference_for_key.zig").BillingPreferenceForKey;
const BillingFeature = @import("billing_feature.zig").BillingFeature;

pub const UpdateBillingPreferencesInput = struct {
    /// Key/value pairs to apply. All keys in a single request must be valid for the
    /// specified `feature` and must not be duplicated. For
    /// `CREDIT_PREFERENCE_OPTIONS`, all keys must reference the same `creditId`.
    billing_preferences_per_key: []const BillingPreferenceForKey,

    /// The feature to update. Valid values: `BILLING_ALERTS`, `RI_SHARING`,
    /// `CREDIT_SHARING`, `CREDIT_LEVEL_SHARING`, `CREDIT_PREFERENCE_OPTIONS`. The
    /// history features (`RI_SHARING_HISTORY` and `CREDIT_SHARING_HISTORY`) are
    /// read-only and cannot be updated.
    feature: BillingFeature,

    pub const json_field_names = .{
        .billing_preferences_per_key = "billingPreferencesPerKey",
        .feature = "feature",
    };
};

pub const UpdateBillingPreferencesOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBillingPreferencesInput, options: CallOptions) !UpdateBillingPreferencesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBillingPreferencesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBilling.UpdateBillingPreferences");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBillingPreferencesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
