const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OriginRequestPolicyType = @import("origin_request_policy_type.zig").OriginRequestPolicyType;
const OriginRequestPolicyList = @import("origin_request_policy_list.zig").OriginRequestPolicyList;
const serde = @import("serde.zig");

pub const ListOriginRequestPoliciesInput = struct {
    /// Use this field when paginating results to indicate where to begin in your
    /// list of origin request policies. The response includes origin request
    /// policies in the list that occur after the marker. To get the next page of
    /// the list, set this field's value to the value of `NextMarker` from the
    /// current page's response.
    marker: ?[]const u8 = null,

    /// The maximum number of origin request policies that you want in the response.
    max_items: ?i32 = null,

    /// A filter to return only the specified kinds of origin request policies.
    /// Valid values are:
    ///
    /// * `managed` – Returns only the managed policies created by Amazon Web
    ///   Services.
    /// * `custom` – Returns only the custom policies created in your Amazon Web
    ///   Services account.
    @"type": ?OriginRequestPolicyType = null,
};

pub const ListOriginRequestPoliciesOutput = struct {
    /// A list of origin request policies.
    origin_request_policy_list: ?OriginRequestPolicyList = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListOriginRequestPoliciesInput, options: CallOptions) !ListOriginRequestPoliciesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudfront", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListOriginRequestPoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2020-05-31/origin-request-policy";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxItems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.@"type") |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Type=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListOriginRequestPoliciesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: ListOriginRequestPoliciesOutput = .{};

    return result;
}
