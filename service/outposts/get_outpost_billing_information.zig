const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PaymentOption = @import("payment_option.zig").PaymentOption;
const PaymentTerm = @import("payment_term.zig").PaymentTerm;
const Subscription = @import("subscription.zig").Subscription;

pub const GetOutpostBillingInformationInput = struct {
    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    /// The ID or ARN of the Outpost.
    outpost_identifier: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .outpost_identifier = "OutpostIdentifier",
    };
};

pub const GetOutpostBillingInformationOutput = struct {
    /// The date the current contract term ends for the specified Outpost. You must
    /// start the
    /// renewal or decommission process at least 5 business days before the current
    /// term for your
    /// Amazon Web Services Outposts ends. Failing to complete these steps at least
    /// 5 business days before the current term
    /// ends might result in unanticipated charges.
    contract_end_date: ?[]const u8 = null,

    next_token: ?[]const u8 = null,

    /// The payment option.
    payment_option: ?PaymentOption = null,

    /// The payment term.
    payment_term: ?PaymentTerm = null,

    /// The subscription details for the specified Outpost.
    subscriptions: ?[]const Subscription = null,

    pub const json_field_names = .{
        .contract_end_date = "ContractEndDate",
        .next_token = "NextToken",
        .payment_option = "PaymentOption",
        .payment_term = "PaymentTerm",
        .subscriptions = "Subscriptions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOutpostBillingInformationInput, options: CallOptions) !GetOutpostBillingInformationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "outposts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOutpostBillingInformationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/outpost/");
    try path_buf.appendSlice(allocator, input.outpost_identifier);
    try path_buf.appendSlice(allocator, "/billing-information");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOutpostBillingInformationOutput {
    var result: GetOutpostBillingInformationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetOutpostBillingInformationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
