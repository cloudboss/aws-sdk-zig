const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrafficPolicySummary = @import("traffic_policy_summary.zig").TrafficPolicySummary;
const serde = @import("serde.zig");

pub const ListTrafficPoliciesInput = struct {
    /// (Optional) The maximum number of traffic policies that you want Amazon Route
    /// 53 to
    /// return in response to this request. If you have more than `MaxItems` traffic
    /// policies, the value of `IsTruncated` in the response is `true`,
    /// and the value of `TrafficPolicyIdMarker` is the ID of the first traffic
    /// policy that Route 53 will return if you submit another request.
    max_items: ?i32 = null,

    /// (Conditional) For your first request to `ListTrafficPolicies`, don't
    /// include the `TrafficPolicyIdMarker` parameter.
    ///
    /// If you have more traffic policies than the value of `MaxItems`,
    /// `ListTrafficPolicies` returns only the first `MaxItems`
    /// traffic policies. To get the next group of policies, submit another request
    /// to
    /// `ListTrafficPolicies`. For the value of
    /// `TrafficPolicyIdMarker`, specify the value of
    /// `TrafficPolicyIdMarker` that was returned in the previous
    /// response.
    traffic_policy_id_marker: ?[]const u8 = null,
};

pub const ListTrafficPoliciesOutput = struct {
    /// A flag that indicates whether there are more traffic policies to be listed.
    /// If the
    /// response was truncated, you can get the next group of traffic policies by
    /// submitting
    /// another `ListTrafficPolicies` request and specifying the value of
    /// `TrafficPolicyIdMarker` in the `TrafficPolicyIdMarker` request
    /// parameter.
    is_truncated: ?bool = null,

    /// The value that you specified for the `MaxItems` parameter in the
    /// `ListTrafficPolicies` request that produced the current response.
    max_items: i32,

    /// If the value of `IsTruncated` is `true`,
    /// `TrafficPolicyIdMarker` is the ID of the first traffic policy in the next
    /// group of `MaxItems` traffic policies.
    traffic_policy_id_marker: []const u8,

    /// A list that contains one `TrafficPolicySummary` element for each traffic
    /// policy that was created by the current Amazon Web Services account.
    traffic_policy_summaries: ?[]const TrafficPolicySummary = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTrafficPoliciesInput, options: CallOptions) !ListTrafficPoliciesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTrafficPoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-04-01/trafficpolicies";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxitems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.traffic_policy_id_marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "trafficpolicyid=");
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTrafficPoliciesOutput {
    var result: ListTrafficPoliciesOutput = undefined;
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "TrafficPolicyIdMarker")) {
                    result.traffic_policy_id_marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrafficPolicySummaries")) {
                    result.traffic_policy_summaries = try serde.deserializeTrafficPolicySummaries(allocator, &reader, "TrafficPolicySummary");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}
