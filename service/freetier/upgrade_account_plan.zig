const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountPlanType = @import("account_plan_type.zig").AccountPlanType;
const AccountPlanStatus = @import("account_plan_status.zig").AccountPlanStatus;

pub const UpgradeAccountPlanInput = struct {
    /// The target account plan type. This makes it explicit about the change and
    /// latest value of the `accountPlanType`.
    account_plan_type: AccountPlanType,

    pub const json_field_names = .{
        .account_plan_type = "accountPlanType",
    };
};

pub const UpgradeAccountPlanOutput = struct {
    /// A unique identifier that identifies the account.
    account_id: []const u8,

    /// This indicates the latest state of the account plan within its lifecycle.
    account_plan_status: AccountPlanStatus,

    /// The type of plan for the account.
    account_plan_type: AccountPlanType,

    pub const json_field_names = .{
        .account_id = "accountId",
        .account_plan_status = "accountPlanStatus",
        .account_plan_type = "accountPlanType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpgradeAccountPlanInput, options: CallOptions) !UpgradeAccountPlanOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpgradeAccountPlanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("freetier", "FreeTier", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSFreeTierService.UpgradeAccountPlan");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpgradeAccountPlanOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpgradeAccountPlanOutput, body, allocator);
}
