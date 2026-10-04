const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Instance = @import("instance.zig").Instance;
const serde = @import("serde.zig");

pub const DeregisterInstancesFromLoadBalancerInput = struct {
    /// The IDs of the instances.
    instances: []const Instance,

    /// The name of the load balancer.
    load_balancer_name: []const u8,
};

pub const DeregisterInstancesFromLoadBalancerOutput = struct {
    /// The remaining instances registered with the load balancer.
    instances: ?[]const Instance = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeregisterInstancesFromLoadBalancerInput, options: CallOptions) !DeregisterInstancesFromLoadBalancerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeregisterInstancesFromLoadBalancerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeregisterInstancesFromLoadBalancer&Version=2012-06-01");
    for (input.instances, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.instance_id) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Instances.member.{d}.InstanceId=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
    }
    try body_buf.appendSlice(allocator, "&LoadBalancerName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.load_balancer_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeregisterInstancesFromLoadBalancerOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeregisterInstancesFromLoadBalancerResult")) break;
            },
            else => {},
        }
    }

    var result: DeregisterInstancesFromLoadBalancerOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Instances")) {
                    result.instances = try serde.deserializeInstances(allocator, &reader, "member");
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
