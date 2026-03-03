const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const VpcAttributeName = @import("vpc_attribute_name.zig").VpcAttributeName;
const AttributeBooleanValue = @import("attribute_boolean_value.zig").AttributeBooleanValue;
const serde = @import("serde.zig");

pub const DescribeVpcAttributeInput = struct {
    /// The VPC attribute.
    attribute: VpcAttributeName,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the VPC.
    vpc_id: []const u8,
};

pub const DescribeVpcAttributeOutput = struct {
    /// Indicates whether the instances launched in the VPC get DNS hostnames.
    /// If this attribute is `true`, instances in the VPC get DNS hostnames;
    /// otherwise, they do not.
    enable_dns_hostnames: ?AttributeBooleanValue = null,

    /// Indicates whether DNS resolution is enabled for
    /// the VPC. If this attribute is `true`, the Amazon DNS server
    /// resolves DNS hostnames for your instances to their corresponding
    /// IP addresses; otherwise, it does not.
    enable_dns_support: ?AttributeBooleanValue = null,

    /// Indicates whether Network Address Usage metrics are enabled for your VPC.
    enable_network_address_usage_metrics: ?AttributeBooleanValue = null,

    /// The ID of the VPC.
    vpc_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeVpcAttributeInput, options: CallOptions) !DescribeVpcAttributeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeVpcAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=DescribeVpcAttribute&Version=2016-11-15");
    try body_buf.appendSlice(allocator, "&Attribute=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.attribute.wireName());
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&VpcId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.vpc_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeVpcAttributeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeVpcAttributeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "enableDnsHostnames")) {
                    result.enable_dns_hostnames = try serde.deserializeAttributeBooleanValue(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "enableDnsSupport")) {
                    result.enable_dns_support = try serde.deserializeAttributeBooleanValue(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "enableNetworkAddressUsageMetrics")) {
                    result.enable_network_address_usage_metrics = try serde.deserializeAttributeBooleanValue(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "vpcId")) {
                    result.vpc_id = try allocator.dupe(u8, try reader.readElementText());
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
