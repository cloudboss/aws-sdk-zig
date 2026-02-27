const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AttributeBooleanValue = @import("attribute_boolean_value.zig").AttributeBooleanValue;
const serde = @import("serde.zig");

pub const ModifyVpcAttributeInput = struct {
    /// Indicates whether the instances launched in the VPC get DNS hostnames. If
    /// enabled, instances in the VPC get DNS hostnames; otherwise, they do not.
    ///
    /// You cannot modify the DNS resolution and DNS hostnames attributes in the
    /// same request. Use separate requests for each attribute. You can only enable
    /// DNS hostnames if you've enabled DNS support.
    enable_dns_hostnames: ?AttributeBooleanValue = null,

    /// Indicates whether the DNS resolution is supported for the VPC. If enabled,
    /// queries to
    /// the Amazon provided DNS server at the 169.254.169.253 IP address, or the
    /// reserved IP
    /// address at the base of the VPC network range "plus two" succeed. If
    /// disabled, the Amazon
    /// provided DNS service in the VPC that resolves public DNS hostnames to IP
    /// addresses is
    /// not enabled.
    ///
    /// You cannot modify the DNS resolution and DNS hostnames attributes in the
    /// same request. Use separate requests for each attribute.
    enable_dns_support: ?AttributeBooleanValue = null,

    /// Indicates whether Network Address Usage metrics are enabled for your VPC.
    enable_network_address_usage_metrics: ?AttributeBooleanValue = null,

    /// The ID of the VPC.
    vpc_id: []const u8,
};

const ModifyVpcAttributeOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyVpcAttributeInput, options: Options) !ModifyVpcAttributeOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyVpcAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyVpcAttribute&Version=2016-11-15");
    if (input.enable_dns_hostnames) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&EnableDnsHostnames.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.enable_dns_support) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&EnableDnsSupport.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.enable_network_address_usage_metrics) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&EnableNetworkAddressUsageMetrics.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    try body_buf.appendSlice(alloc, "&VpcId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.vpc_id);

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyVpcAttributeOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: ModifyVpcAttributeOutput = .{};

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
