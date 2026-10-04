const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MonetaryAmount = @import("monetary_amount.zig").MonetaryAmount;
const AccountPlanStatus = @import("account_plan_status.zig").AccountPlanStatus;
const AccountPlanType = @import("account_plan_type.zig").AccountPlanType;

pub const GetAccountPlanStateInput = struct {
};

pub const GetAccountPlanStateOutput = struct {
    /// A unique identifier that identifies the account.
    account_id: []const u8,

    /// The timestamp for when the current account plan expires.
    account_plan_expiration_date: ?i64 = null,

    /// The amount of credits remaining for the account.
    account_plan_remaining_credits: ?MonetaryAmount = null,

    /// The current status for the account plan.
    account_plan_status: AccountPlanStatus,

    /// The plan type for the account.
    account_plan_type: AccountPlanType,

    pub const json_field_names = .{
        .account_id = "accountId",
        .account_plan_expiration_date = "accountPlanExpirationDate",
        .account_plan_remaining_credits = "accountPlanRemainingCredits",
        .account_plan_status = "accountPlanStatus",
        .account_plan_type = "accountPlanType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccountPlanStateInput, options: CallOptions) !GetAccountPlanStateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsfreetierservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccountPlanStateInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("freetier", "FreeTier", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSFreeTierService.GetAccountPlanState");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccountPlanStateOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetAccountPlanStateOutput, body, allocator);
}
