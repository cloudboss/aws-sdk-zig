const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FreeTrialAccountInfo = @import("free_trial_account_info.zig").FreeTrialAccountInfo;
const FreeTrialInfoError = @import("free_trial_info_error.zig").FreeTrialInfoError;

pub const BatchGetFreeTrialInfoInput = struct {
    /// The account IDs to get free trial status for.
    account_ids: []const []const u8,

    pub const json_field_names = .{
        .account_ids = "accountIds",
    };
};

pub const BatchGetFreeTrialInfoOutput = struct {
    /// An array of objects that provide Amazon Inspector free trial details for
    /// each of the requested
    /// accounts.
    accounts: ?[]const FreeTrialAccountInfo = null,

    /// An array of objects detailing any accounts that free trial data could not be
    /// returned
    /// for.
    failed_accounts: ?[]const FreeTrialInfoError = null,

    pub const json_field_names = .{
        .accounts = "accounts",
        .failed_accounts = "failedAccounts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetFreeTrialInfoInput, options: CallOptions) !BatchGetFreeTrialInfoOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetFreeTrialInfoInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/freetrialinfo/batchget";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"accountIds\":");
    try aws.json.writeValue(@TypeOf(input.account_ids), input.account_ids, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetFreeTrialInfoOutput {
    var result: BatchGetFreeTrialInfoOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetFreeTrialInfoOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
