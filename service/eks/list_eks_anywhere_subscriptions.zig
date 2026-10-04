const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EksAnywhereSubscriptionStatus = @import("eks_anywhere_subscription_status.zig").EksAnywhereSubscriptionStatus;
const EksAnywhereSubscription = @import("eks_anywhere_subscription.zig").EksAnywhereSubscription;

pub const ListEksAnywhereSubscriptionsInput = struct {
    /// An array of subscription statuses to filter on.
    include_status: ?[]const EksAnywhereSubscriptionStatus = null,

    /// The maximum number of cluster results returned by
    /// ListEksAnywhereSubscriptions in
    /// paginated output. When you use this parameter, ListEksAnywhereSubscriptions
    /// returns only
    /// maxResults results in a single page along with a nextToken response element.
    /// You can see
    /// the remaining results of the initial request by sending another
    /// ListEksAnywhereSubscriptions request with the returned nextToken value. This
    /// value can
    /// be between 1 and 100. If you don't use this parameter,
    /// ListEksAnywhereSubscriptions
    /// returns up to 10 results and a nextToken value if applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `ListEksAnywhereSubscriptions` request where `maxResults` was
    /// used and the results exceeded the value of that parameter. Pagination
    /// continues from the
    /// end of the previous results that returned the `nextToken` value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .include_status = "includeStatus",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListEksAnywhereSubscriptionsOutput = struct {
    /// The nextToken value to include in a future ListEksAnywhereSubscriptions
    /// request. When
    /// the results of a ListEksAnywhereSubscriptions request exceed maxResults, you
    /// can use
    /// this value to retrieve the next page of results. This value is null when
    /// there are no
    /// more results to return.
    next_token: ?[]const u8 = null,

    /// A list of all subscription objects in the region, filtered by includeStatus
    /// and
    /// paginated by nextToken and maxResults.
    subscriptions: ?[]const EksAnywhereSubscription = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .subscriptions = "subscriptions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEksAnywhereSubscriptionsInput, options: CallOptions) !ListEksAnywhereSubscriptionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "eks", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEksAnywhereSubscriptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/eks-anywhere-subscriptions";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.include_status) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "includeStatus=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEksAnywhereSubscriptionsOutput {
    const result: ListEksAnywhereSubscriptionsOutput = try aws.json.parseJsonObject(
        ListEksAnywhereSubscriptionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
