const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrafficPolicy = @import("traffic_policy.zig").TrafficPolicy;
const serde = @import("serde.zig");

pub const ListTrafficPolicyVersionsInput = struct {
    /// Specify the value of `Id` of the traffic policy for which you want to list
    /// all versions.
    id: []const u8,

    /// The maximum number of traffic policy versions that you want Amazon Route 53
    /// to include
    /// in the response body for this request. If the specified traffic policy has
    /// more than
    /// `MaxItems` versions, the value of `IsTruncated` in the
    /// response is `true`, and the value of the
    /// `TrafficPolicyVersionMarker` element is the ID of the first version that
    /// Route 53 will return if you submit another request.
    max_items: ?i32 = null,

    /// For your first request to `ListTrafficPolicyVersions`, don't include the
    /// `TrafficPolicyVersionMarker` parameter.
    ///
    /// If you have more traffic policy versions than the value of `MaxItems`,
    /// `ListTrafficPolicyVersions` returns only the first group of
    /// `MaxItems` versions. To get more traffic policy versions, submit another
    /// `ListTrafficPolicyVersions` request. For the value of
    /// `TrafficPolicyVersionMarker`, specify the value of
    /// `TrafficPolicyVersionMarker` in the previous response.
    traffic_policy_version_marker: ?[]const u8 = null,
};

pub const ListTrafficPolicyVersionsOutput = struct {
    /// A flag that indicates whether there are more traffic policies to be listed.
    /// If the
    /// response was truncated, you can get the next group of traffic policies by
    /// submitting
    /// another `ListTrafficPolicyVersions` request and specifying the value of
    /// `NextMarker` in the `marker` parameter.
    is_truncated: ?bool = null,

    /// The value that you specified for the `maxitems` parameter in the
    /// `ListTrafficPolicyVersions` request that produced the current
    /// response.
    max_items: i32,

    /// A list that contains one `TrafficPolicy` element for each traffic policy
    /// version that is associated with the specified traffic policy.
    traffic_policies: ?[]const TrafficPolicy = null,

    /// If `IsTruncated` is `true`, the value of
    /// `TrafficPolicyVersionMarker` identifies the first traffic policy that
    /// Amazon Route 53 will return if you submit another request. Call
    /// `ListTrafficPolicyVersions` again and specify the value of
    /// `TrafficPolicyVersionMarker` in the
    /// `TrafficPolicyVersionMarker` request parameter.
    ///
    /// This element is present only if `IsTruncated` is `true`.
    traffic_policy_version_marker: []const u8,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTrafficPolicyVersionsInput, options: CallOptions) !ListTrafficPolicyVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTrafficPolicyVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2013-04-01/trafficpolicies/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/versions");
    const path = try path_buf.toOwnedSlice(allocator);

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
    if (input.traffic_policy_version_marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "trafficpolicyversion=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTrafficPolicyVersionsOutput {
    var result: ListTrafficPolicyVersionsOutput = undefined;
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
                } else if (std.mem.eql(u8, e.local, "TrafficPolicies")) {
                    result.traffic_policies = try serde.deserializeTrafficPolicies(allocator, &reader, "TrafficPolicy");
                } else if (std.mem.eql(u8, e.local, "TrafficPolicyVersionMarker")) {
                    result.traffic_policy_version_marker = try allocator.dupe(u8, try reader.readElementText());
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
