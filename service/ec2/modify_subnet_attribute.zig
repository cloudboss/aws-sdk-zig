const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AttributeBooleanValue = @import("attribute_boolean_value.zig").AttributeBooleanValue;
const HostnameType = @import("hostname_type.zig").HostnameType;
const serde = @import("serde.zig");

pub const ModifySubnetAttributeInput = struct {
    /// Specify `true` to indicate that network interfaces created in the
    /// specified subnet should be assigned an IPv6 address. This includes a network
    /// interface
    /// that's created when launching an instance into the subnet (the instance
    /// therefore
    /// receives an IPv6 address).
    ///
    /// If you enable the IPv6 addressing feature for your subnet, your network
    /// interface
    /// or instance only receives an IPv6 address if it's created using version
    /// `2016-11-15` or later of the Amazon EC2 API.
    assign_ipv_6_address_on_creation: ?AttributeBooleanValue = null,

    /// The customer-owned IPv4 address pool associated with the subnet.
    ///
    /// You must set this value when you specify `true` for
    /// `MapCustomerOwnedIpOnLaunch`.
    customer_owned_ipv_4_pool: ?[]const u8 = null,

    /// Specify `true` to indicate that local network interfaces at the current
    /// position should be disabled.
    disable_lni_at_device_index: ?AttributeBooleanValue = null,

    /// Indicates whether DNS queries made to the Amazon-provided DNS Resolver in
    /// this subnet
    /// should return synthetic IPv6 addresses for IPv4-only destinations.
    ///
    /// You must first configure a NAT gateway in a public subnet (separate from the
    /// subnet
    /// containing the IPv6-only workloads). For example, the subnet containing the
    /// NAT gateway
    /// should have a `0.0.0.0/0` route pointing to the internet gateway. For more
    /// information, see [Configure DNS64 and
    /// NAT64](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateway-nat64-dns64.html#nat-gateway-nat64-dns64-walkthrough) in the *Amazon VPC User Guide*.
    enable_dns_64: ?AttributeBooleanValue = null,

    /// Indicates the device position for local network interfaces in this subnet.
    /// For example,
    /// `1` indicates local network interfaces in this subnet are the secondary
    /// network interface (eth1). A local network interface cannot be the primary
    /// network
    /// interface (eth0).
    enable_lni_at_device_index: ?i32 = null,

    /// Indicates whether to respond to DNS queries for instance hostnames with DNS
    /// AAAA records.
    enable_resource_name_dns_aaaa_record_on_launch: ?AttributeBooleanValue = null,

    /// Indicates whether to respond to DNS queries for instance hostnames with DNS
    /// A records.
    enable_resource_name_dns_a_record_on_launch: ?AttributeBooleanValue = null,

    /// Specify `true` to indicate that network interfaces attached to instances
    /// created in the
    /// specified subnet should be assigned a customer-owned IPv4 address.
    ///
    /// When this value is `true`, you must specify the customer-owned IP pool using
    /// `CustomerOwnedIpv4Pool`.
    map_customer_owned_ip_on_launch: ?AttributeBooleanValue = null,

    /// Specify `true` to indicate that network interfaces attached to instances
    /// created in the
    /// specified subnet should be assigned a public IPv4 address.
    ///
    /// Amazon Web Services charges for all public IPv4 addresses, including public
    /// IPv4 addresses
    /// associated with running instances and Elastic IP addresses. For more
    /// information, see the *Public IPv4 Address* tab on the [Amazon VPC pricing
    /// page](http://aws.amazon.com/vpc/pricing/).
    map_public_ip_on_launch: ?AttributeBooleanValue = null,

    /// The type of hostname to assign to instances in the subnet at launch. For
    /// IPv4-only and dual-stack (IPv4 and IPv6) subnets, an
    /// instance DNS name can be based on the instance IPv4 address (ip-name) or the
    /// instance ID (resource-name). For IPv6 only subnets, an instance
    /// DNS name must be based on the instance ID (resource-name).
    private_dns_hostname_type_on_launch: ?HostnameType = null,

    /// The ID of the subnet.
    subnet_id: []const u8,
};

pub const ModifySubnetAttributeOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifySubnetAttributeInput, options: CallOptions) !ModifySubnetAttributeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifySubnetAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifySubnetAttribute&Version=2016-11-15");
    if (input.assign_ipv_6_address_on_creation) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(allocator, "&AssignIpv6AddressOnCreation.Value=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.customer_owned_ipv_4_pool) |v| {
        try body_buf.appendSlice(allocator, "&CustomerOwnedIpv4Pool=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.disable_lni_at_device_index) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(allocator, "&DisableLniAtDeviceIndex.Value=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.enable_dns_64) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(allocator, "&EnableDns64.Value=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.enable_lni_at_device_index) |v| {
        try body_buf.appendSlice(allocator, "&EnableLniAtDeviceIndex=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.enable_resource_name_dns_aaaa_record_on_launch) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(allocator, "&EnableResourceNameDnsAAAARecordOnLaunch.Value=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.enable_resource_name_dns_a_record_on_launch) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(allocator, "&EnableResourceNameDnsARecordOnLaunch.Value=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.map_customer_owned_ip_on_launch) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(allocator, "&MapCustomerOwnedIpOnLaunch.Value=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.map_public_ip_on_launch) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(allocator, "&MapPublicIpOnLaunch.Value=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.private_dns_hostname_type_on_launch) |v| {
        try body_buf.appendSlice(allocator, "&PrivateDnsHostnameTypeOnLaunch=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&SubnetId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.subnet_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifySubnetAttributeOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: ModifySubnetAttributeOutput = .{};

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
