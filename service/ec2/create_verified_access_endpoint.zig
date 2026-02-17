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
const serde = @import("serde.zig");

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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateVerifiedAccessEndpointOutput) void {
        self._arena.deinit();
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateVerifiedAccessEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateVerifiedAccessEndpoint&Version=2016-11-15");
    if (input.application_domain) |v| {
        try body_buf.appendSlice(alloc, "&ApplicationDomain=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&AttachmentType=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(input.attachment_type));
    if (input.cidr_options) |v| {
        if (v.cidr) |sv| {
            try body_buf.appendSlice(alloc, "&CidrOptions.Cidr=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.port_ranges) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CidrOptions.PortRanges.item.{d}.FromPort=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.from_port) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CidrOptions.PortRanges.item.{d}.ToPort=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.to_port) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
            }
        }
        if (v.protocol) |sv| {
            try body_buf.appendSlice(alloc, "&CidrOptions.Protocol=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.subnet_ids) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CidrOptions.SubnetIds.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.domain_certificate_arn) |v| {
        try body_buf.appendSlice(alloc, "&DomainCertificateArn=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.endpoint_domain_prefix) |v| {
        try body_buf.appendSlice(alloc, "&EndpointDomainPrefix=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&EndpointType=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(input.endpoint_type));
    if (input.load_balancer_options) |v| {
        if (v.load_balancer_arn) |sv| {
            try body_buf.appendSlice(alloc, "&LoadBalancerOptions.LoadBalancerArn=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.port) |sv| {
            try body_buf.appendSlice(alloc, "&LoadBalancerOptions.Port=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.port_ranges) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadBalancerOptions.PortRanges.item.{d}.FromPort=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.from_port) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadBalancerOptions.PortRanges.item.{d}.ToPort=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.to_port) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
            }
        }
        if (v.protocol) |sv| {
            try body_buf.appendSlice(alloc, "&LoadBalancerOptions.Protocol=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.subnet_ids) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadBalancerOptions.SubnetIds.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
    }
    if (input.network_interface_options) |v| {
        if (v.network_interface_id) |sv| {
            try body_buf.appendSlice(alloc, "&NetworkInterfaceOptions.NetworkInterfaceId=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.port) |sv| {
            try body_buf.appendSlice(alloc, "&NetworkInterfaceOptions.Port=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.port_ranges) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaceOptions.PortRanges.item.{d}.FromPort=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.from_port) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaceOptions.PortRanges.item.{d}.ToPort=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.to_port) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
            }
        }
        if (v.protocol) |sv| {
            try body_buf.appendSlice(alloc, "&NetworkInterfaceOptions.Protocol=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    if (input.policy_document) |v| {
        try body_buf.appendSlice(alloc, "&PolicyDocument=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.rds_options) |v| {
        if (v.port) |sv| {
            try body_buf.appendSlice(alloc, "&RdsOptions.Port=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.protocol) |sv| {
            try body_buf.appendSlice(alloc, "&RdsOptions.Protocol=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.rds_db_cluster_arn) |sv| {
            try body_buf.appendSlice(alloc, "&RdsOptions.RdsDbClusterArn=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.rds_db_instance_arn) |sv| {
            try body_buf.appendSlice(alloc, "&RdsOptions.RdsDbInstanceArn=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.rds_db_proxy_arn) |sv| {
            try body_buf.appendSlice(alloc, "&RdsOptions.RdsDbProxyArn=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.rds_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&RdsOptions.RdsEndpoint=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.subnet_ids) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RdsOptions.SubnetIds.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
    }
    if (input.security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroupIds.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.sse_specification) |v| {
        if (v.customer_managed_key_enabled) |sv| {
            try body_buf.appendSlice(alloc, "&SseSpecification.CustomerManagedKeyEnabled=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.kms_key_arn) |sv| {
            try body_buf.appendSlice(alloc, "&SseSpecification.KmsKeyArn=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    try body_buf.appendSlice(alloc, "&VerifiedAccessGroupId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.verified_access_group_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateVerifiedAccessEndpointOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateVerifiedAccessEndpointOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "verifiedAccessEndpoint")) {
                    result.verified_access_endpoint = try serde.deserializeVerifiedAccessEndpoint(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
