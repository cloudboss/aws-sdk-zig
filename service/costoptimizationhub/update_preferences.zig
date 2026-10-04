const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MemberAccountDiscountVisibility = @import("member_account_discount_visibility.zig").MemberAccountDiscountVisibility;
const PreferredCommitment = @import("preferred_commitment.zig").PreferredCommitment;
const SavingsEstimationMode = @import("savings_estimation_mode.zig").SavingsEstimationMode;

pub const UpdatePreferencesInput = struct {
    /// Sets the "member account discount visibility" preference.
    member_account_discount_visibility: ?MemberAccountDiscountVisibility = null,

    /// Sets the preferences for how Reserved Instances and Savings Plans
    /// cost-saving opportunities are prioritized in terms of payment option and
    /// term length.
    preferred_commitment: ?PreferredCommitment = null,

    /// Sets the "savings estimation mode" preference.
    savings_estimation_mode: ?SavingsEstimationMode = null,

    pub const json_field_names = .{
        .member_account_discount_visibility = "memberAccountDiscountVisibility",
        .preferred_commitment = "preferredCommitment",
        .savings_estimation_mode = "savingsEstimationMode",
    };
};

pub const UpdatePreferencesOutput = struct {
    /// Shows the status of the "member account discount visibility" preference.
    member_account_discount_visibility: ?MemberAccountDiscountVisibility = null,

    /// Shows the updated preferences for how Reserved Instances and Savings Plans
    /// cost-saving opportunities are prioritized in terms of payment option and
    /// term length.
    preferred_commitment: ?PreferredCommitment = null,

    /// Shows the status of the "savings estimation mode" preference.
    savings_estimation_mode: ?SavingsEstimationMode = null,

    pub const json_field_names = .{
        .member_account_discount_visibility = "memberAccountDiscountVisibility",
        .preferred_commitment = "preferredCommitment",
        .savings_estimation_mode = "savingsEstimationMode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePreferencesInput, options: CallOptions) !UpdatePreferencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "costoptimizationhubservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePreferencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cost-optimization-hub", "Cost Optimization Hub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CostOptimizationHubService.UpdatePreferences");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePreferencesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdatePreferencesOutput, body, allocator);
}
