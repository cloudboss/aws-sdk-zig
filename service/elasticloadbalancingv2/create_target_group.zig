const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ProtocolEnum = @import("protocol_enum.zig").ProtocolEnum;
const TargetGroupIpAddressTypeEnum = @import("target_group_ip_address_type_enum.zig").TargetGroupIpAddressTypeEnum;
const Matcher = @import("matcher.zig").Matcher;
const Tag = @import("tag.zig").Tag;
const TargetTypeEnum = @import("target_type_enum.zig").TargetTypeEnum;
const TargetGroup = @import("target_group.zig").TargetGroup;
const serde = @import("serde.zig");

pub const CreateTargetGroupInput = struct {
    /// Indicates whether health checks are enabled. If the target type is `lambda`,
    /// health checks are disabled by default but can be enabled. If the target type
    /// is
    /// `instance`, `ip`, or `alb`, health checks are always
    /// enabled and can't be disabled.
    health_check_enabled: ?bool = null,

    /// The approximate amount of time, in seconds, between health checks of an
    /// individual target. The range is 5-300.
    /// If the target group protocol is TCP, TLS, UDP, TCP_UDP, QUIC, TCP_QUIC, HTTP
    /// or HTTPS, the default is 30 seconds.
    /// If the target group protocol is GENEVE, the default is 10 seconds.
    /// If the target type is `lambda`, the default is 35 seconds.
    health_check_interval_seconds: ?i32 = null,

    /// [HTTP/HTTPS health checks] The destination for health checks on the targets.
    ///
    /// [HTTP1 or HTTP2 protocol version] The ping path. The default is /.
    ///
    /// [GRPC protocol version] The path of a custom health check method with the
    /// format
    /// /package.service/method. The default is /Amazon Web
    /// Services.ALB/healthcheck.
    health_check_path: ?[]const u8 = null,

    /// The port the load balancer uses when performing health checks on targets. If
    /// the protocol
    /// is HTTP, HTTPS, TCP, TLS, UDP, TCP_UDP, QUIC, or TCP_QUIC the default is
    /// `traffic-port`, which is
    /// the port on which each target receives traffic from the load balancer. If
    /// the protocol is
    /// GENEVE, the default is port 80.
    health_check_port: ?[]const u8 = null,

    /// The protocol the load balancer uses when performing health checks on
    /// targets. For
    /// Application Load Balancers, the default is HTTP. For Network Load Balancers
    /// and Gateway Load
    /// Balancers, the default is TCP. The TCP protocol is not supported for health
    /// checks if the
    /// protocol of the target group is HTTP or HTTPS. The GENEVE, TLS, UDP,
    /// TCP_UDP, QUIC, and TCP_QUIC protocols are
    /// not supported for health checks.
    health_check_protocol: ?ProtocolEnum = null,

    /// The amount of time, in seconds, during which no response from a target means
    /// a failed
    /// health check. The range is 2–120 seconds. For target groups with a protocol
    /// of HTTP, the
    /// default is 6 seconds. For target groups with a protocol of TCP, TLS or
    /// HTTPS, the default
    /// is 10 seconds. For target groups with a protocol of GENEVE, the default is 5
    /// seconds. If
    /// the target type is `lambda`, the default is 30 seconds.
    health_check_timeout_seconds: ?i32 = null,

    /// The number of consecutive health check successes required before considering
    /// a target healthy. The range is
    /// 2-10. If the target group protocol is TCP, TCP_UDP, UDP, TLS, HTTP or HTTPS,
    /// the default is 5. For target groups
    /// with a protocol of GENEVE, the default is 5. If the target type
    /// is `lambda`, the default is 5.
    healthy_threshold_count: ?i32 = null,

    /// The IP address type. The default value is `ipv4`.
    ip_address_type: ?TargetGroupIpAddressTypeEnum = null,

    /// [HTTP/HTTPS health checks] The HTTP or gRPC codes to use when checking for a
    /// successful
    /// response from a target. For target groups with a protocol of TCP, TCP_UDP,
    /// UDP, QUIC, TCP_QUIC, or TLS the range
    /// is 200-599. For target groups with a protocol of HTTP or HTTPS, the range is
    /// 200-499. For target
    /// groups with a protocol of GENEVE, the range is 200-399.
    matcher: ?Matcher = null,

    /// The name of the target group.
    ///
    /// This name must be unique per region per account, can have a maximum of 32
    /// characters, must
    /// contain only alphanumeric characters or hyphens, and must not begin or end
    /// with a
    /// hyphen.
    name: []const u8,

    /// The port on which the targets receive traffic. This port is used unless you
    /// specify a port
    /// override when registering the target. If the target is a Lambda function,
    /// this parameter does
    /// not apply. If the protocol is GENEVE, the supported port is 6081.
    port: ?i32 = null,

    /// The protocol to use for routing traffic to the targets. For Application Load
    /// Balancers,
    /// the supported protocols are HTTP and HTTPS. For Network Load Balancers, the
    /// supported
    /// protocols are TCP, TLS, UDP, TCP_UDP, QUIC, or TCP_QUIC. For Gateway Load
    /// Balancers, the supported protocol is
    /// GENEVE. A TCP_UDP listener must be associated with a TCP_UDP target group. A
    /// TCP_QUIC listener must be associated with a TCP_QUIC target group. If the
    /// target is a
    /// Lambda function, this parameter does not apply.
    protocol: ?ProtocolEnum = null,

    /// [HTTP/HTTPS protocol] The protocol version. Specify `GRPC` to send requests
    /// to
    /// targets using gRPC. Specify `HTTP2` to send requests to targets using
    /// HTTP/2. The
    /// default is `HTTP1`, which sends requests to targets using HTTP/1.1.
    protocol_version: ?[]const u8 = null,

    /// The tags to assign to the target group.
    tags: ?[]const Tag = null,

    /// The port on which the target control agent and application load balancer
    /// exchange management traffic for the target optimizer feature.
    target_control_port: ?i32 = null,

    /// The type of target that you must specify when registering targets with this
    /// target group.
    /// You can't specify targets for a target group using more than one target
    /// type.
    ///
    /// * `instance` - Register targets by instance ID. This is the default
    /// value.
    ///
    /// * `ip` - Register targets by IP address. You can specify IP addresses from
    /// the subnets of the virtual private cloud (VPC) for the target group, the RFC
    /// 1918 range
    /// (10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16), and the RFC 6598 range
    /// (100.64.0.0/10).
    /// You can't specify publicly routable IP addresses.
    ///
    /// * `lambda` - Register a single Lambda function as a target.
    ///
    /// * `alb` - Register a single Application Load Balancer as a target.
    target_type: ?TargetTypeEnum = null,

    /// The number of consecutive health check failures required before considering
    /// a target unhealthy. The range is
    /// 2-10. If the target group protocol is TCP, TCP_UDP, UDP, TLS, QUIC,
    /// TCP_QUIC, HTTP or HTTPS, the default is 2. For target groups
    /// with a protocol of GENEVE, the default is 2. If the target type
    /// is `lambda`, the default is 5.
    unhealthy_threshold_count: ?i32 = null,

    /// The identifier of the virtual private cloud (VPC). If the target is a Lambda
    /// function,
    /// this parameter does not apply. Otherwise, this parameter is required.
    vpc_id: ?[]const u8 = null,
};

pub const CreateTargetGroupOutput = struct {
    /// Information about the target group.
    target_groups: ?[]const TargetGroup = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTargetGroupInput, options: Options) !CreateTargetGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "elasticloadbalancingv2");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateTargetGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancingv2", "Elastic Load Balancing v2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateTargetGroup&Version=2015-12-01");
    if (input.health_check_enabled) |v| {
        try body_buf.appendSlice(alloc, "&HealthCheckEnabled=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.health_check_interval_seconds) |v| {
        try body_buf.appendSlice(alloc, "&HealthCheckIntervalSeconds=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.health_check_path) |v| {
        try body_buf.appendSlice(alloc, "&HealthCheckPath=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.health_check_port) |v| {
        try body_buf.appendSlice(alloc, "&HealthCheckPort=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.health_check_protocol) |v| {
        try body_buf.appendSlice(alloc, "&HealthCheckProtocol=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.health_check_timeout_seconds) |v| {
        try body_buf.appendSlice(alloc, "&HealthCheckTimeoutSeconds=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.healthy_threshold_count) |v| {
        try body_buf.appendSlice(alloc, "&HealthyThresholdCount=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.ip_address_type) |v| {
        try body_buf.appendSlice(alloc, "&IpAddressType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.matcher) |v| {
        if (v.grpc_code) |sv| {
            try body_buf.appendSlice(alloc, "&Matcher.GrpcCode=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.http_code) |sv| {
            try body_buf.appendSlice(alloc, "&Matcher.HttpCode=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    try body_buf.appendSlice(alloc, "&Name=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.name);
    if (input.port) |v| {
        try body_buf.appendSlice(alloc, "&Port=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.protocol) |v| {
        try body_buf.appendSlice(alloc, "&Protocol=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.protocol_version) |v| {
        try body_buf.appendSlice(alloc, "&ProtocolVersion=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.target_control_port) |v| {
        try body_buf.appendSlice(alloc, "&TargetControlPort=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.target_type) |v| {
        try body_buf.appendSlice(alloc, "&TargetType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.unhealthy_threshold_count) |v| {
        try body_buf.appendSlice(alloc, "&UnhealthyThresholdCount=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.vpc_id) |v| {
        try body_buf.appendSlice(alloc, "&VpcId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateTargetGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateTargetGroupResult")) break;
            },
            else => {},
        }
    }

    var result: CreateTargetGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TargetGroups")) {
                    result.target_groups = try serde.deserializeTargetGroups(&reader, alloc, "member");
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AllocationIdNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .allocation_id_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ALPNPolicyNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .alpn_policy_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AvailabilityZoneNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .availability_zone_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CaCertificatesBundleNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .ca_certificates_bundle_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CapacityDecreaseRequestsLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .capacity_decrease_requests_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CapacityReservationPendingException")) {
        return .{ .arena = arena, .kind = .{ .capacity_reservation_pending_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CapacityUnitsLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .capacity_units_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CertificateNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .certificate_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DeleteAssociationSameAccountException")) {
        return .{ .arena = arena, .kind = .{ .delete_association_same_account_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateListenerException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_listener_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateLoadBalancerNameException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_load_balancer_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateTagKeysException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_tag_keys_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateTargetGroupNameException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_target_group_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateTrustStoreNameException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_trust_store_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HealthUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .health_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncompatibleProtocolsException")) {
        return .{ .arena = arena, .kind = .{ .incompatible_protocols_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientCapacityException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_capacity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCaCertificatesBundleException")) {
        return .{ .arena = arena, .kind = .{ .invalid_ca_certificates_bundle_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidConfigurationRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_configuration_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLoadBalancerActionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_load_balancer_action_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRevocationContentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_revocation_content_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSchemeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_scheme_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityGroupException")) {
        return .{ .arena = arena, .kind = .{ .invalid_security_group_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnetException")) {
        return .{ .arena = arena, .kind = .{ .invalid_subnet_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetException")) {
        return .{ .arena = arena, .kind = .{ .invalid_target_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ListenerNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .listener_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LoadBalancerNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .load_balancer_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotPermittedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_permitted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PriorRequestNotCompleteException")) {
        return .{ .arena = arena, .kind = .{ .prior_request_not_complete_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PriorityInUseException")) {
        return .{ .arena = arena, .kind = .{ .priority_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RevocationContentNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .revocation_content_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RevocationIdNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .revocation_id_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RuleNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .rule_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SSLPolicyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .ssl_policy_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .subnet_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TargetGroupAssociationLimitException")) {
        return .{ .arena = arena, .kind = .{ .target_group_association_limit_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TargetGroupNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .target_group_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyActionsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_actions_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyCertificatesException")) {
        return .{ .arena = arena, .kind = .{ .too_many_certificates_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyListenersException")) {
        return .{ .arena = arena, .kind = .{ .too_many_listeners_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyLoadBalancersException")) {
        return .{ .arena = arena, .kind = .{ .too_many_load_balancers_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRegistrationsForTargetIdException")) {
        return .{ .arena = arena, .kind = .{ .too_many_registrations_for_target_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRulesException")) {
        return .{ .arena = arena, .kind = .{ .too_many_rules_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTargetGroupsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_target_groups_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTargetsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_targets_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTrustStoreRevocationEntriesException")) {
        return .{ .arena = arena, .kind = .{ .too_many_trust_store_revocation_entries_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTrustStoresException")) {
        return .{ .arena = arena, .kind = .{ .too_many_trust_stores_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyUniqueTargetGroupsPerLoadBalancerException")) {
        return .{ .arena = arena, .kind = .{ .too_many_unique_target_groups_per_load_balancer_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrustStoreAssociationNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .trust_store_association_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrustStoreInUseException")) {
        return .{ .arena = arena, .kind = .{ .trust_store_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrustStoreNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .trust_store_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrustStoreNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .trust_store_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedProtocolException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_protocol_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
