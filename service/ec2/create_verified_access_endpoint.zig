const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const VerifiedAccessEndpointAttachmentType = @import("verified_access_endpoint_attachment_type.zig").VerifiedAccessEndpointAttachmentType;
const CreateVerifiedAccessEndpointCidrOptions = @import("create_verified_access_endpoint_cidr_options.zig").CreateVerifiedAccessEndpointCidrOptions;
const VerifiedAccessEndpointType = @import("verified_access_endpoint_type.zig").VerifiedAccessEndpointType;
const CreateVerifiedAccessEndpointLoadBalancerOptions = @import("create_verified_access_endpoint_load_balancer_options.zig").CreateVerifiedAccessEndpointLoadBalancerOptions;
const CreateVerifiedAccessEndpointEniOptions = @import("create_verified_access_endpoint_eni_options.zig").CreateVerifiedAccessEndpointEniOptions;
const CreateVerifiedAccessEndpointRdsOptions = @import("create_verified_access_endpoint_rds_options.zig").CreateVerifiedAccessEndpointRdsOptions;
const VerifiedAccessSseSpecificationRequest = @import("verified_access_sse_specification_request.zig").VerifiedAccessSseSpecificationRequest;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const VerifiedAccessEndpoint = @import("verified_access_endpoint.zig").VerifiedAccessEndpoint;

/// An Amazon Web Services Verified Access endpoint is where you define your
/// application along with an optional endpoint-level access policy.
pub const CreateVerifiedAccessEndpointInput = struct {
    /// The DNS name for users to reach your application.
    application_domain: ?[]const u8 = null,

    /// The type of attachment.
    attachment_type: VerifiedAccessEndpointAttachmentType,

    /// The CIDR options. This parameter is required if the endpoint type is `cidr`.
    cidr_options: ?CreateVerifiedAccessEndpointCidrOptions = null,

    /// A unique, case-sensitive token that you provide to ensure idempotency of
    /// your
    /// modification request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// A description for the Verified Access endpoint.
    description: ?[]const u8 = null,

    /// The ARN of the public TLS/SSL certificate in Amazon Web Services Certificate
    /// Manager to associate with the endpoint.
    /// The CN in the certificate must match the DNS name your end users will use to
    /// reach your
    /// application.
    domain_certificate_arn: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// A custom identifier that is prepended to the DNS name that is generated for
    /// the
    /// endpoint.
    endpoint_domain_prefix: ?[]const u8 = null,

    /// The type of Verified Access endpoint to create.
    endpoint_type: VerifiedAccessEndpointType,

    /// The load balancer details. This parameter is required if the endpoint type
    /// is
    /// `load-balancer`.
    load_balancer_options: ?CreateVerifiedAccessEndpointLoadBalancerOptions = null,

    /// The network interface details. This parameter is required if the endpoint
    /// type is
    /// `network-interface`.
    network_interface_options: ?CreateVerifiedAccessEndpointEniOptions = null,

    /// The Verified Access policy document.
    policy_document: ?[]const u8 = null,

    /// The RDS details. This parameter is required if the endpoint type is `rds`.
    rds_options: ?CreateVerifiedAccessEndpointRdsOptions = null,

    /// The IDs of the security groups to associate with the Verified Access
    /// endpoint. Required if `AttachmentType` is set to `vpc`.
    security_group_ids: ?[]const []const u8 = null,

    /// The options for server side encryption.
    sse_specification: ?VerifiedAccessSseSpecificationRequest = null,

    /// The tags to assign to the Verified Access endpoint.
    tag_specifications: ?[]const TagSpecification = null,

    /// The ID of the Verified Access group to associate the endpoint with.
    verified_access_group_id: []const u8,
};

pub const CreateVerifiedAccessEndpointOutput = struct {
    /// Details about the Verified Access endpoint.
    verified_access_endpoint: ?VerifiedAccessEndpoint = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateVerifiedAccessEndpointOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateVerifiedAccessEndpointInput, options: Options) !CreateVerifiedAccessEndpointOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateVerifiedAccessEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateVerifiedAccessEndpoint&Version=2016-11-15");
    if (input.application_domain) |v| {
        try body_buf.appendSlice(alloc, "&ApplicationDomain=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&AttachmentType=");
    try appendUrlEncoded(alloc, &body_buf, @tagName(input.attachment_type));
    if (input.cidr_options) |v| {
        if (v.cidr) |sv| {
            try body_buf.appendSlice(alloc, "&CidrOptions.Cidr=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.protocol) |sv| {
            try body_buf.appendSlice(alloc, "&CidrOptions.Protocol=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.domain_certificate_arn) |v| {
        try body_buf.appendSlice(alloc, "&DomainCertificateArn=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.endpoint_domain_prefix) |v| {
        try body_buf.appendSlice(alloc, "&EndpointDomainPrefix=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&EndpointType=");
    try appendUrlEncoded(alloc, &body_buf, @tagName(input.endpoint_type));
    if (input.load_balancer_options) |v| {
        if (v.load_balancer_arn) |sv| {
            try body_buf.appendSlice(alloc, "&LoadBalancerOptions.LoadBalancerArn=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.port) |sv| {
            try body_buf.appendSlice(alloc, "&LoadBalancerOptions.Port=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.protocol) |sv| {
            try body_buf.appendSlice(alloc, "&LoadBalancerOptions.Protocol=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    if (input.network_interface_options) |v| {
        if (v.network_interface_id) |sv| {
            try body_buf.appendSlice(alloc, "&NetworkInterfaceOptions.NetworkInterfaceId=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.port) |sv| {
            try body_buf.appendSlice(alloc, "&NetworkInterfaceOptions.Port=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.protocol) |sv| {
            try body_buf.appendSlice(alloc, "&NetworkInterfaceOptions.Protocol=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    if (input.policy_document) |v| {
        try body_buf.appendSlice(alloc, "&PolicyDocument=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.rds_options) |v| {
        if (v.port) |sv| {
            try body_buf.appendSlice(alloc, "&RdsOptions.Port=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.protocol) |sv| {
            try body_buf.appendSlice(alloc, "&RdsOptions.Protocol=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.rds_db_cluster_arn) |sv| {
            try body_buf.appendSlice(alloc, "&RdsOptions.RdsDbClusterArn=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.rds_db_instance_arn) |sv| {
            try body_buf.appendSlice(alloc, "&RdsOptions.RdsDbInstanceArn=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.rds_db_proxy_arn) |sv| {
            try body_buf.appendSlice(alloc, "&RdsOptions.RdsDbProxyArn=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.rds_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&RdsOptions.RdsEndpoint=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroupIds.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.sse_specification) |v| {
        if (v.customer_managed_key_enabled) |sv| {
            try body_buf.appendSlice(alloc, "&SseSpecification.CustomerManagedKeyEnabled=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.kms_key_arn) |sv| {
            try body_buf.appendSlice(alloc, "&SseSpecification.KmsKeyArn=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |v| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(v));
                }
            }
        }
    }
    try body_buf.appendSlice(alloc, "&VerifiedAccessGroupId=");
    try appendUrlEncoded(alloc, &body_buf, input.verified_access_group_id);

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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !CreateVerifiedAccessEndpointOutput {
    _ = status;
    _ = body;
    const result: CreateVerifiedAccessEndpointOutput = .{ .allocator = alloc };

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
