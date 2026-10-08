const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountLimitType = @import("account_limit_type.zig").AccountLimitType;
const AccountLimit = @import("account_limit.zig").AccountLimit;
const serde = @import("serde.zig");

pub const GetAccountLimitInput = struct {
    /// The limit that you want to get. Valid values include the following:
    ///
    /// * **MAX_HEALTH_CHECKS_BY_OWNER**: The maximum
    /// number of health checks that you can create using the current account.
    ///
    /// * **MAX_HOSTED_ZONES_BY_OWNER**: The maximum number
    /// of hosted zones that you can create using the current account.
    ///
    /// * **MAX_REUSABLE_DELEGATION_SETS_BY_OWNER**: The
    /// maximum number of reusable delegation sets that you can create using the
    /// current
    /// account.
    ///
    /// * **MAX_TRAFFIC_POLICIES_BY_OWNER**: The maximum
    /// number of traffic policies that you can create using the current account.
    ///
    /// * **MAX_TRAFFIC_POLICY_INSTANCES_BY_OWNER**: The
    /// maximum number of traffic policy instances that you can create using the
    /// current
    /// account. (Traffic policy instances are referred to as traffic flow policy
    /// records in the Amazon Route 53 console.)
    type: AccountLimitType,
};

pub const GetAccountLimitOutput = struct {
    /// The current number of entities that you have created of the specified type.
    /// For
    /// example, if you specified `MAX_HEALTH_CHECKS_BY_OWNER` for the value of
    /// `Type` in the request, the value of `Count` is the current
    /// number of health checks that you have created using the current account.
    count: ?i64 = null,

    /// The current setting for the specified limit. For example, if you specified
    /// `MAX_HEALTH_CHECKS_BY_OWNER` for the value of `Type` in the
    /// request, the value of `Limit` is the maximum number of health checks that
    /// you
    /// can create using the current account.
    limit: ?AccountLimit = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccountLimitInput, options: CallOptions) !GetAccountLimitOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccountLimitInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2013-04-01/accountlimit/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccountLimitOutput {
    var result: GetAccountLimitOutput = undefined;
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
                    result.limit = try serde.deserializeAccountLimit(allocator, &reader);
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
