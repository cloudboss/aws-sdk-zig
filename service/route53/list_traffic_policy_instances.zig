const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RRType = @import("rr_type.zig").RRType;
const TrafficPolicyInstance = @import("traffic_policy_instance.zig").TrafficPolicyInstance;
const serde = @import("serde.zig");

pub const ListTrafficPolicyInstancesInput = struct {
    /// If the value of `IsTruncated` in the previous response was
    /// `true`, you have more traffic policy instances. To get more traffic
    /// policy instances, submit another `ListTrafficPolicyInstances` request. For
    /// the value of `HostedZoneId`, specify the value of
    /// `HostedZoneIdMarker` from the previous response, which is the hosted zone
    /// ID of the first traffic policy instance in the next group of traffic policy
    /// instances.
    ///
    /// If the value of `IsTruncated` in the previous response was
    /// `false`, there are no more traffic policy instances to get.
    hosted_zone_id_marker: ?[]const u8 = null,

    /// The maximum number of traffic policy instances that you want Amazon Route 53
    /// to return
    /// in response to a `ListTrafficPolicyInstances` request. If you have more than
    /// `MaxItems` traffic policy instances, the value of the
    /// `IsTruncated` element in the response is `true`, and the
    /// values of `HostedZoneIdMarker`, `TrafficPolicyInstanceNameMarker`,
    /// and `TrafficPolicyInstanceTypeMarker` represent the first traffic policy
    /// instance in the next group of `MaxItems` traffic policy instances.
    max_items: ?i32 = null,

    /// If the value of `IsTruncated` in the previous response was
    /// `true`, you have more traffic policy instances. To get more traffic
    /// policy instances, submit another `ListTrafficPolicyInstances` request. For
    /// the value of `trafficpolicyinstancename`, specify the value of
    /// `TrafficPolicyInstanceNameMarker` from the previous response, which is
    /// the name of the first traffic policy instance in the next group of traffic
    /// policy
    /// instances.
    ///
    /// If the value of `IsTruncated` in the previous response was
    /// `false`, there are no more traffic policy instances to get.
    traffic_policy_instance_name_marker: ?[]const u8 = null,

    /// If the value of `IsTruncated` in the previous response was
    /// `true`, you have more traffic policy instances. To get more traffic
    /// policy instances, submit another `ListTrafficPolicyInstances` request. For
    /// the value of `trafficpolicyinstancetype`, specify the value of
    /// `TrafficPolicyInstanceTypeMarker` from the previous response, which is
    /// the type of the first traffic policy instance in the next group of traffic
    /// policy
    /// instances.
    ///
    /// If the value of `IsTruncated` in the previous response was
    /// `false`, there are no more traffic policy instances to get.
    traffic_policy_instance_type_marker: ?RRType = null,
};

pub const ListTrafficPolicyInstancesOutput = struct {
    /// If `IsTruncated` is `true`, `HostedZoneIdMarker` is
    /// the ID of the hosted zone of the first traffic policy instance that Route 53
    /// will return
    /// if you submit another `ListTrafficPolicyInstances` request.
    hosted_zone_id_marker: ?[]const u8 = null,

    /// A flag that indicates whether there are more traffic policy instances to be
    /// listed. If
    /// the response was truncated, you can get more traffic policy instances by
    /// calling
    /// `ListTrafficPolicyInstances` again and specifying the values of the
    /// `HostedZoneIdMarker`, `TrafficPolicyInstanceNameMarker`, and
    /// `TrafficPolicyInstanceTypeMarker` in the corresponding request
    /// parameters.
    is_truncated: ?bool = null,

    /// The value that you specified for the `MaxItems` parameter in the call to
    /// `ListTrafficPolicyInstances` that produced the current response.
    max_items: i32,

    /// If `IsTruncated` is `true`,
    /// `TrafficPolicyInstanceNameMarker` is the name of the first traffic policy
    /// instance that Route 53 will return if you submit another
    /// `ListTrafficPolicyInstances` request.
    traffic_policy_instance_name_marker: ?[]const u8 = null,

    /// A list that contains one `TrafficPolicyInstance` element for each traffic
    /// policy instance that matches the elements in the request.
    traffic_policy_instances: ?[]const TrafficPolicyInstance = null,

    /// If `IsTruncated` is `true`,
    /// `TrafficPolicyInstanceTypeMarker` is the DNS type of the resource record
    /// sets that are associated with the first traffic policy instance that Amazon
    /// Route 53
    /// will return if you submit another `ListTrafficPolicyInstances` request.
    traffic_policy_instance_type_marker: ?RRType = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTrafficPolicyInstancesInput, options: CallOptions) !ListTrafficPolicyInstancesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTrafficPolicyInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-04-01/trafficpolicyinstances";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.hosted_zone_id_marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "hostedzoneid=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxitems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.traffic_policy_instance_name_marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "trafficpolicyinstancename=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.traffic_policy_instance_type_marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "trafficpolicyinstancetype=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTrafficPolicyInstancesOutput {
    var result: ListTrafficPolicyInstancesOutput = undefined;
    result.hosted_zone_id_marker = null;
    result.traffic_policy_instance_name_marker = null;
    result.traffic_policy_instance_type_marker = null;
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
                if (std.mem.eql(u8, e.local, "HostedZoneIdMarker")) {
                    result.hosted_zone_id_marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "TrafficPolicyInstanceNameMarker")) {
                    result.traffic_policy_instance_name_marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrafficPolicyInstances")) {
                    result.traffic_policy_instances = try serde.deserializeTrafficPolicyInstances(allocator, &reader, "TrafficPolicyInstance");
                } else if (std.mem.eql(u8, e.local, "TrafficPolicyInstanceTypeMarker")) {
                    result.traffic_policy_instance_type_marker = RRType.fromWireName(try reader.readElementText());
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
