const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SchedulingPolicyListingDetail = @import("scheduling_policy_listing_detail.zig").SchedulingPolicyListingDetail;

pub const ListSchedulingPoliciesInput = struct {
    /// The maximum number of results that's returned by `ListSchedulingPolicies` in
    /// paginated output. When this parameter is used, `ListSchedulingPolicies` only
    /// returns `maxResults` results in a single page and a `nextToken` response
    /// element. You can see the remaining results of the initial request by sending
    /// another
    /// `ListSchedulingPolicies` request with the returned `nextToken` value.
    /// This value can be between 1 and 100. If this parameter isn't
    /// used, `ListSchedulingPolicies` returns up to 100 results and a
    /// `nextToken` value if applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value that's returned from a previous paginated
    /// `ListSchedulingPolicies` request where `maxResults` was used and the
    /// results exceeded the value of that parameter. Pagination continues from the
    /// end of the
    /// previous results that returned the `nextToken` value. This value is
    /// `null` when there are no more results to return.
    ///
    /// Treat this token as an opaque identifier that's only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListSchedulingPoliciesOutput = struct {
    /// The `nextToken` value to include in a future
    /// `ListSchedulingPolicies` request. When the results of a
    /// `ListSchedulingPolicies` request exceed `maxResults`, this value can
    /// be used to retrieve the next page of results. This value is `null` when
    /// there are
    /// no more results to return.
    next_token: ?[]const u8 = null,

    /// A list of scheduling policies that match the request.
    scheduling_policies: ?[]const SchedulingPolicyListingDetail = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .scheduling_policies = "schedulingPolicies",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSchedulingPoliciesInput, options: CallOptions) !ListSchedulingPoliciesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "batch", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSchedulingPoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/listschedulingpolicies";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSchedulingPoliciesOutput {
    const result: ListSchedulingPoliciesOutput = try aws.json.parseJsonObject(
        ListSchedulingPoliciesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
