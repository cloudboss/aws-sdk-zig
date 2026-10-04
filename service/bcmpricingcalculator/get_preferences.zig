const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RateType = @import("rate_type.zig").RateType;

pub const GetPreferencesInput = struct {
};

pub const GetPreferencesOutput = struct {
    /// The preferred rate types for the management account.
    management_account_rate_type_selections: ?[]const RateType = null,

    /// The preferred rate types for member accounts.
    member_account_rate_type_selections: ?[]const RateType = null,

    /// The preferred rate types for a standalone account.
    standalone_account_rate_type_selections: ?[]const RateType = null,

    pub const json_field_names = .{
        .management_account_rate_type_selections = "managementAccountRateTypeSelections",
        .member_account_rate_type_selections = "memberAccountRateTypeSelections",
        .standalone_account_rate_type_selections = "standaloneAccountRateTypeSelections",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPreferencesInput, options: CallOptions) !GetPreferencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bcm-pricing-calculator", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPreferencesInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("bcm-pricing-calculator", "BCM Pricing Calculator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSBCMPricingCalculator.GetPreferences");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPreferencesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetPreferencesOutput, body, allocator);
}
