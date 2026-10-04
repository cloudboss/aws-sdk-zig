const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FreeTrialStatusValue = @import("free_trial_status_value.zig").FreeTrialStatusValue;
const AccountFreeTrialStatus = @import("account_free_trial_status.zig").AccountFreeTrialStatus;

pub const ListFreeTrialStatusesV2Input = struct {
    /// The Amazon Web Services account identifiers to list free trial status for.
    /// You can specify accounts other than your own only if you are a delegated
    /// Security Hub administrator.
    account_ids: ?[]const []const u8 = null,

    /// The maximum number of results to return. If you don't specify a value,
    /// Security Hub returns up to 100 results.
    max_results: ?i32 = null,

    /// The pagination token to request the next page of results.
    next_token: ?[]const u8 = null,

    /// The free trial statuses to filter the results by. Valid values:
    ///
    /// * `ACTIVE` returns only features with an ongoing free trial period.
    ///
    /// * `INACTIVE` returns only features whose free trial period has ended, or
    ///   that never started.
    statuses: ?[]const FreeTrialStatusValue = null,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .statuses = "Statuses",
    };
};

pub const ListFreeTrialStatusesV2Output = struct {
    /// An array of free trial statuses, one for each account in scope.
    account_free_trial_statuses: ?[]const AccountFreeTrialStatus = null,

    /// The pagination token to use to request the next page of results. If there
    /// are no additional results, this value is null.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_free_trial_statuses = "AccountFreeTrialStatuses",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFreeTrialStatusesV2Input, options: CallOptions) !ListFreeTrialStatusesV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFreeTrialStatusesV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/freetrial/statusv2/list";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccountIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.statuses) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Statuses\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFreeTrialStatusesV2Output {
    const result: ListFreeTrialStatusesV2Output = try aws.json.parseJsonObject(
        ListFreeTrialStatusesV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
