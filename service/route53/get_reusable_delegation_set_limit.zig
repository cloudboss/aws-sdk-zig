const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReusableDelegationSetLimitType = @import("reusable_delegation_set_limit_type.zig").ReusableDelegationSetLimitType;
const ReusableDelegationSetLimit = @import("reusable_delegation_set_limit.zig").ReusableDelegationSetLimit;
const serde = @import("serde.zig");

pub const GetReusableDelegationSetLimitInput = struct {
    /// The ID of the delegation set that you want to get the limit for.
    delegation_set_id: []const u8,

    /// Specify `MAX_ZONES_BY_REUSABLE_DELEGATION_SET` to get the maximum number of
    /// hosted zones that you can associate with the specified reusable delegation
    /// set.
    type: ReusableDelegationSetLimitType,
};

pub const GetReusableDelegationSetLimitOutput = struct {
    /// The current number of hosted zones that you can associate with the specified
    /// reusable
    /// delegation set.
    count: ?i64 = null,

    /// The current setting for the limit on hosted zones that you can associate
    /// with the
    /// specified reusable delegation set.
    limit: ?ReusableDelegationSetLimit = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReusableDelegationSetLimitInput, options: CallOptions) !GetReusableDelegationSetLimitOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetReusableDelegationSetLimitInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2013-04-01/reusabledelegationsetlimit/");
    try path_buf.appendSlice(allocator, input.delegation_set_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.type.wireName());
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetReusableDelegationSetLimitOutput {
    var result: GetReusableDelegationSetLimitOutput = undefined;
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
                if (std.mem.eql(u8, e.local, "Count")) {
                    result.count = try std.fmt.parseInt(i64, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Limit")) {
                    result.limit = try serde.deserializeReusableDelegationSetLimit(allocator, &reader);
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
