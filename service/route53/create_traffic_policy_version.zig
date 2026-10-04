const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrafficPolicy = @import("traffic_policy.zig").TrafficPolicy;
const serde = @import("serde.zig");

pub const CreateTrafficPolicyVersionInput = struct {
    /// The comment that you specified in the `CreateTrafficPolicyVersion` request,
    /// if any.
    comment: ?[]const u8 = null,

    /// The definition of this version of the traffic policy, in JSON format. You
    /// specified
    /// the JSON in the `CreateTrafficPolicyVersion` request. For more information
    /// about the JSON format, see
    /// [CreateTrafficPolicy](https://docs.aws.amazon.com/Route53/latest/APIReference/API_CreateTrafficPolicy.html).
    document: []const u8,

    /// The ID of the traffic policy for which you want to create a new version.
    id: []const u8,
};

pub const CreateTrafficPolicyVersionOutput = struct {
    /// A unique URL that represents a new traffic policy version.
    location: []const u8,

    /// A complex type that contains settings for the new version of the traffic
    /// policy.
    traffic_policy: ?TrafficPolicy = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTrafficPolicyVersionInput, options: CallOptions) !CreateTrafficPolicyVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTrafficPolicyVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2013-04-01/trafficpolicy/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CreateTrafficPolicyVersionRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">");
    if (input.comment) |v| {
        try body_buf.appendSlice(allocator, "<Comment>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</Comment>");
    }
    try body_buf.appendSlice(allocator, "<Document>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.document);
    try body_buf.appendSlice(allocator, "</Document>");
    try body_buf.appendSlice(allocator, "</CreateTrafficPolicyVersionRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTrafficPolicyVersionOutput {
    var result: CreateTrafficPolicyVersionOutput = undefined;
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
                if (std.mem.eql(u8, e.local, "TrafficPolicy")) {
                    result.traffic_policy = try serde.deserializeTrafficPolicy(allocator, &reader);
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
