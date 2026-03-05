const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const AuthorizationRule = @import("authorization_rule.zig").AuthorizationRule;
const serde = @import("serde.zig");

pub const DescribeClientVpnAuthorizationRulesInput = struct {
    /// The ID of the Client VPN endpoint.
    client_vpn_endpoint_id: []const u8,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// One or more filters. Filter names and values are case-sensitive.
    ///
    /// * `description` - The description of the authorization rule.
    ///
    /// * `destination-cidr` - The CIDR of the network to which the authorization
    ///   rule
    /// applies.
    ///
    /// * `group-id` - The ID of the Active Directory group to which the
    ///   authorization rule grants access.
    filters: ?[]const Filter = null,

    /// The maximum number of results to return for the request in a single page.
    /// The remaining results can be seen by sending another request with the
    /// nextToken value.
    max_results: ?i32 = null,

    /// The token to retrieve the next page of results.
    next_token: ?[]const u8 = null,
};

pub const DescribeClientVpnAuthorizationRulesOutput = struct {
    /// Information about the authorization rules.
    authorization_rules: ?[]const AuthorizationRule = null,

    /// The token to use to retrieve the next page of results. This value is `null`
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeClientVpnAuthorizationRulesInput, options: CallOptions) !DescribeClientVpnAuthorizationRulesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeClientVpnAuthorizationRulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=DescribeClientVpnAuthorizationRules&Version=2016-11-15");
    try body_buf.appendSlice(allocator, "&ClientVpnEndpointId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.client_vpn_endpoint_id);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.name) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.{d}.Value.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeClientVpnAuthorizationRulesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeClientVpnAuthorizationRulesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "authorizationRule")) {
                    result.authorization_rules = try serde.deserializeAuthorizationRuleSet(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
