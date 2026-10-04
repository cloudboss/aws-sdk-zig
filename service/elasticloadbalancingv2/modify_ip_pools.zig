const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpamPools = @import("ipam_pools.zig").IpamPools;
const RemoveIpamPoolEnum = @import("remove_ipam_pool_enum.zig").RemoveIpamPoolEnum;
const serde = @import("serde.zig");

pub const ModifyIpPoolsInput = struct {
    /// The IPAM pools to be modified.
    ipam_pools: ?IpamPools = null,

    /// The Amazon Resource Name (ARN) of the load balancer.
    load_balancer_arn: []const u8,

    /// Remove the IP pools in use by the load balancer.
    remove_ipam_pools: ?[]const RemoveIpamPoolEnum = null,
};

pub const ModifyIpPoolsOutput = struct {
    /// The IPAM pool ID.
    ipam_pools: ?IpamPools = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyIpPoolsInput, options: CallOptions) !ModifyIpPoolsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticloadbalancing", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyIpPoolsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing v2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyIpPools&Version=2015-12-01");
    if (input.ipam_pools) |v| {
        if (v.ipv_4_ipam_pool_id) |sv| {
            try body_buf.appendSlice(allocator, "&IpamPools.Ipv4IpamPoolId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    try body_buf.appendSlice(allocator, "&LoadBalancerArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.load_balancer_arn);
    if (input.remove_ipam_pools) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveIpamPools.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyIpPoolsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyIpPoolsResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyIpPoolsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IpamPools")) {
                    result.ipam_pools = try serde.deserializeIpamPools(allocator, &reader);
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
