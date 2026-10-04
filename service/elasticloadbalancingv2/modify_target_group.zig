const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyTargetGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing v2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

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
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
