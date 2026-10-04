const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LinkedAccountCharge = @import("linked_account_charge.zig").LinkedAccountCharge;

pub const ListEnterpriseSupportLinkedAccountChargesInput = struct {
    /// The linked account ID to filter results to a specific account. If you don't
    /// specify a value, the response includes charges for all linked accounts.
    account_id: ?[]const u8 = null,

    /// The billing month in YYYY-MM format. This must be a month in the past.
    billing_month: []const u8,

    /// The maximum number of results to return per page. Default is 100.
    max_results: ?i32 = null,

    /// The pagination token for the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .billing_month = "billingMonth",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListEnterpriseSupportLinkedAccountChargesOutput = struct {
    /// The list of Enterprise Support charges per linked account.
    linked_account: ?[]const LinkedAccountCharge = null,

    /// The pagination token for the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .linked_account = "linkedAccount",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEnterpriseSupportLinkedAccountChargesInput, options: CallOptions) !ListEnterpriseSupportLinkedAccountChargesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEnterpriseSupportLinkedAccountChargesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBilling.ListEnterpriseSupportLinkedAccountCharges");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEnterpriseSupportLinkedAccountChargesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListEnterpriseSupportLinkedAccountChargesOutput, body, allocator);
}
