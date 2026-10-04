const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrafficPolicyInstance = @import("traffic_policy_instance.zig").TrafficPolicyInstance;
const serde = @import("serde.zig");

pub const CreateTrafficPolicyInstanceInput = struct {
    /// The ID of the hosted zone that you want Amazon Route 53 to create resource
    /// record sets
    /// in by using the configuration in a traffic policy.
    hosted_zone_id: []const u8,

    /// The domain name (such as example.com) or subdomain name (such as
    /// www.example.com) for
    /// which Amazon Route 53 responds to DNS queries by using the resource record
    /// sets that
    /// Route 53 creates for this traffic policy instance.
    name: []const u8,

    /// The ID of the traffic policy that you want to use to create resource record
    /// sets in
    /// the specified hosted zone.
    traffic_policy_id: []const u8,

    /// The version of the traffic policy that you want to use to create resource
    /// record sets
    /// in the specified hosted zone.
    traffic_policy_version: i32,

    /// (Optional) The TTL that you want Amazon Route 53 to assign to all of the
    /// resource
    /// record sets that it creates in the specified hosted zone.
    ttl: i64,
};

pub const CreateTrafficPolicyInstanceOutput = struct {
    /// A unique URL that represents a new traffic policy instance.
    location: []const u8,

    /// A complex type that contains settings for the new traffic policy instance.
    traffic_policy_instance: ?TrafficPolicyInstance = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTrafficPolicyInstanceInput, options: CallOptions) !CreateTrafficPolicyInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTrafficPolicyInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-04-01/trafficpolicyinstance";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CreateTrafficPolicyInstanceRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">");
    try body_buf.appendSlice(allocator, "<HostedZoneId>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.hosted_zone_id);
    try body_buf.appendSlice(allocator, "</HostedZoneId>");
    try body_buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.name);
    try body_buf.appendSlice(allocator, "</Name>");
    try body_buf.appendSlice(allocator, "<TrafficPolicyId>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.traffic_policy_id);
    try body_buf.appendSlice(allocator, "</TrafficPolicyId>");
    try body_buf.appendSlice(allocator, "<TrafficPolicyVersion>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.traffic_policy_version}) catch "";
        try body_buf.appendSlice(allocator, num_str);
    }
    try body_buf.appendSlice(allocator, "</TrafficPolicyVersion>");
    try body_buf.appendSlice(allocator, "<TTL>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.ttl}) catch "";
        try body_buf.appendSlice(allocator, num_str);
    }
    try body_buf.appendSlice(allocator, "</TTL>");
    try body_buf.appendSlice(allocator, "</CreateTrafficPolicyInstanceRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTrafficPolicyInstanceOutput {
    var result: CreateTrafficPolicyInstanceOutput = undefined;
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
                if (std.mem.eql(u8, e.local, "TrafficPolicyInstance")) {
                    result.traffic_policy_instance = try serde.deserializeTrafficPolicyInstance(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    if (headers.get("location")) |value| {
        result.location = try allocator.dupe(u8, value);
    }

    return result;
}
