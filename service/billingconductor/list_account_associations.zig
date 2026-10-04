const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListAccountAssociationsFilter = @import("list_account_associations_filter.zig").ListAccountAssociationsFilter;
const AccountAssociationsListElement = @import("account_associations_list_element.zig").AccountAssociationsListElement;

pub const ListAccountAssociationsInput = struct {
    /// The preferred billing period to get account associations.
    billing_period: ?[]const u8 = null,

    /// The filter on the account ID of the linked account, or any of the following:
    ///
    /// `MONITORED`: linked accounts that are associated to billing groups.
    ///
    /// `UNMONITORED`: linked accounts that aren't associated to billing groups.
    ///
    /// `Billing Group Arn`: linked accounts that are associated to the provided
    /// billing group Arn.
    filters: ?ListAccountAssociationsFilter = null,

    /// The pagination token that's used on subsequent calls to retrieve accounts.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .billing_period = "BillingPeriod",
        .filters = "Filters",
        .next_token = "NextToken",
    };
};

pub const ListAccountAssociationsOutput = struct {
    /// The list of linked accounts in the payer account.
    linked_accounts: ?[]const AccountAssociationsListElement = null,

    /// The pagination token that's used on subsequent calls to get accounts.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .linked_accounts = "LinkedAccounts",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAccountAssociationsInput, options: CallOptions) !ListAccountAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "billingconductor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAccountAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billingconductor", "billingconductor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-account-associations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.billing_period) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BillingPeriod\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAccountAssociationsOutput {
    const result: ListAccountAssociationsOutput = try aws.json.parseJsonObject(
        ListAccountAssociationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
