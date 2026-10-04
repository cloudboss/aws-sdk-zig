const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceScanType = @import("resource_scan_type.zig").ResourceScanType;
const Account = @import("account.zig").Account;
const FailedAccount = @import("failed_account.zig").FailedAccount;

pub const EnableInput = struct {
    /// A list of account IDs you want to enable Amazon Inspector scans for.
    account_ids: ?[]const []const u8 = null,

    /// The idempotency token for the request.
    client_token: ?[]const u8 = null,

    /// The resource scan types you want to enable.
    resource_types: []const ResourceScanType,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .client_token = "clientToken",
        .resource_types = "resourceTypes",
    };
};

pub const EnableOutput = struct {
    /// Information on the accounts that have had Amazon Inspector scans
    /// successfully enabled. Details are
    /// provided for each account.
    accounts: ?[]const Account = null,

    /// Information on any accounts for which Amazon Inspector scans could not be
    /// enabled. Details are
    /// provided for each account.
    failed_accounts: ?[]const FailedAccount = null,

    pub const json_field_names = .{
        .accounts = "accounts",
        .failed_accounts = "failedAccounts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EnableInput, options: CallOptions) !EnableOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: EnableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/enable";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accountIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceTypes\":");
    try aws.json.writeValue(@TypeOf(input.resource_types), input.resource_types, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EnableOutput {
    var result: EnableOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(EnableOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
