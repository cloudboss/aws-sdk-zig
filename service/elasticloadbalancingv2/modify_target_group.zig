const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ProtocolEnum = @import("protocol_enum.zig").ProtocolEnum;
const Matcher = @import("matcher.zig").Matcher;
const TargetGroup = @import("target_group.zig").TargetGroup;
const serde = @import("serde.zig");

pub const ModifyTargetGroupInput = struct {
    /// Indicates whether health checks are enabled. If the target type is `lambda`,
    /// health checks are disabled by default but can be enabled. If the target type
    /// is
    /// `instance`, `ip`, or `alb`, health checks are always
    /// enabled and can't be disabled.
    health_check_enabled: ?bool = null,

    /// The approximate amount of time, in seconds, between health checks of an
    /// individual target.
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

    /// The port the load balancer uses when performing health checks on targets.
    health_check_port: ?[]const u8 = null,

    /// The protocol the load balancer uses when performing health checks on
    /// targets. For
    /// Application Load Balancers, the default is HTTP. For Network Load Balancers
    /// and Gateway Load
    /// Balancers, the default is TCP. The TCP protocol is not supported for health
    /// checks if the
    /// protocol of the target group is HTTP or HTTPS. It is supported for health
    /// checks only if the
    /// protocol of the target group is TCP, TLS, UDP, or TCP_UDP. The GENEVE, TLS,
    /// UDP, TCP_UDP, QUIC, and TCP_QUIC
    /// protocols are not supported for health checks.
    health_check_protocol: ?ProtocolEnum = null,

    /// [HTTP/HTTPS health checks] The amount of time, in seconds, during which no
    /// response means
    /// a failed health check.
    health_check_timeout_seconds: ?i32 = null,

    /// The number of consecutive health checks successes required before
    /// considering an unhealthy
    /// target healthy.
    healthy_threshold_count: ?i32 = null,

    /// [HTTP/HTTPS health checks] The HTTP or gRPC codes to use when checking for a
    /// successful
    /// response from a target. For target groups with a protocol of TCP, TCP_UDP,
    /// UDP or TLS the range
    /// is 200-599. For target groups with a protocol of HTTP or HTTPS, the range is
    /// 200-499. For target
    /// groups with a protocol of GENEVE, the range is 200-399.
    matcher: ?Matcher = null,

    /// The Amazon Resource Name (ARN) of the target group.
    target_group_arn: []const u8,

    /// The number of consecutive health check failures required before considering
    /// the target
    /// unhealthy.
    unhealthy_threshold_count: ?i32 = null,
};

pub const ModifyTargetGroupOutput = struct {
    /// Information about the modified target group.
    target_groups: ?[]const TargetGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyTargetGroupInput, options: CallOptions) !ModifyTargetGroupOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyTargetGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancingv2", "Elastic Load Balancing v2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyTargetGroup&Version=2015-12-01");
    if (input.health_check_enabled) |v| {
        try body_buf.appendSlice(allocator, "&HealthCheckEnabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.health_check_interval_seconds) |v| {
        try body_buf.appendSlice(allocator, "&HealthCheckIntervalSeconds=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.health_check_path) |v| {
        try body_buf.appendSlice(allocator, "&HealthCheckPath=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.health_check_port) |v| {
        try body_buf.appendSlice(allocator, "&HealthCheckPort=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.health_check_protocol) |v| {
        try body_buf.appendSlice(allocator, "&HealthCheckProtocol=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.health_check_timeout_seconds) |v| {
        try body_buf.appendSlice(allocator, "&HealthCheckTimeoutSeconds=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.healthy_threshold_count) |v| {
        try body_buf.appendSlice(allocator, "&HealthyThresholdCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.matcher) |v| {
        if (v.grpc_code) |sv| {
            try body_buf.appendSlice(allocator, "&Matcher.GrpcCode=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.http_code) |sv| {
            try body_buf.appendSlice(allocator, "&Matcher.HttpCode=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    try body_buf.appendSlice(allocator, "&TargetGroupArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.target_group_arn);
    if (input.unhealthy_threshold_count) |v| {
        try body_buf.appendSlice(allocator, "&UnhealthyThresholdCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyTargetGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyTargetGroupResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyTargetGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TargetGroups")) {
                    result.target_groups = try serde.deserializeTargetGroups(allocator, &reader, "member");
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
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
