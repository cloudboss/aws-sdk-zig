const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AttributeBooleanValue = @import("attribute_boolean_value.zig").AttributeBooleanValue;

/// Modifies the specified attribute of the specified VPC.
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

pub const ModifyVpcAttributeOutput = struct {

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const ModifyVpcAttributeOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyVpcAttributeInput, options: Options) !ModifyVpcAttributeOutput {
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
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyVpcAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyVpcAttribute&Version=2016-11-15");
    if (input.enable_dns_hostnames) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&EnableDnsHostnames.Value=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.enable_dns_support) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&EnableDnsSupport.Value=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.enable_network_address_usage_metrics) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&EnableNetworkAddressUsageMetrics.Value=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    try body_buf.appendSlice(alloc, "&VpcId=");
    try appendUrlEncoded(alloc, &body_buf, input.vpc_id);

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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ModifyVpcAttributeOutput {
    _ = status;
    _ = body;
    const result: ModifyVpcAttributeOutput = .{ .allocator = alloc };

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
