const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Listener = @import("listener.zig").Listener;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const CreateLoadBalancerInput = struct {
    /// One or more Availability Zones from the same region as the load balancer.
    ///
    /// You must specify at least one Availability Zone.
    ///
    /// You can add more Availability Zones after you create the load balancer using
    /// EnableAvailabilityZonesForLoadBalancer.
    availability_zones: ?[]const []const u8 = null,

    /// The listeners.
    ///
    /// For more information, see [Listeners for Your Classic Load
    /// Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-listener-config.html)
    /// in the *Classic Load Balancers Guide*.
    listeners: []const Listener,

    /// The name of the load balancer.
    ///
    /// This name must be unique within your set of load balancers for the region,
    /// must have a maximum of 32 characters, must contain only alphanumeric
    /// characters or hyphens, and cannot begin or end with a hyphen.
    load_balancer_name: []const u8,

    /// The type of a load balancer. Valid only for load balancers in a VPC.
    ///
    /// By default, Elastic Load Balancing creates an Internet-facing load balancer
    /// with a DNS name that resolves to public IP addresses.
    /// For more information about Internet-facing and Internal load balancers, see
    /// [Load Balancer
    /// Scheme](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/how-elastic-load-balancing-works.html#load-balancer-scheme)
    /// in the *Elastic Load Balancing User Guide*.
    ///
    /// Specify `internal` to create a load balancer with a DNS name that resolves
    /// to private IP addresses.
    scheme: ?[]const u8 = null,

    /// The IDs of the security groups to assign to the load balancer.
    security_groups: ?[]const []const u8 = null,

    /// The IDs of the subnets in your VPC to attach to the load balancer.
    /// Specify one subnet per Availability Zone specified in `AvailabilityZones`.
    subnets: ?[]const []const u8 = null,

    /// A list of tags to assign to the load balancer.
    ///
    /// For more information about tagging your load balancer, see [Tag Your Classic
    /// Load
    /// Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/add-remove-tags.html)
    /// in the *Classic Load Balancers Guide*.
    tags: ?[]const Tag = null,
};

pub const CreateLoadBalancerOutput = struct {
    /// The DNS name of the load balancer.
    dns_name: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLoadBalancerInput, options: CallOptions) !CreateLoadBalancerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLoadBalancerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateLoadBalancer&Version=2012-06-01");
    if (input.availability_zones) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AvailabilityZones.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    for (input.listeners, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Listeners.member.{d}.InstancePort=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{item.instance_port}) catch "");
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.instance_protocol) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Listeners.member.{d}.InstanceProtocol=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Listeners.member.{d}.LoadBalancerPort=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{item.load_balancer_port}) catch "");
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Listeners.member.{d}.Protocol=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.protocol);
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.ssl_certificate_id) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Listeners.member.{d}.SSLCertificateId=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
    }
    try body_buf.appendSlice(allocator, "&LoadBalancerName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.load_balancer_name);
    if (input.scheme) |v| {
        try body_buf.appendSlice(allocator, "&Scheme=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.security_groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroups.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.subnets) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Subnets.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLoadBalancerOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateLoadBalancerResult")) break;
            },
            else => {},
        }
    }

    var result: CreateLoadBalancerOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DNSName")) {
                    result.dns_name = try allocator.dupe(u8, try reader.readElementText());
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
