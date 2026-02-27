const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EndpointConfiguration = @import("endpoint_configuration.zig").EndpointConfiguration;
const HealthCheckProtocol = @import("health_check_protocol.zig").HealthCheckProtocol;
const PortOverride = @import("port_override.zig").PortOverride;
const EndpointGroup = @import("endpoint_group.zig").EndpointGroup;

pub const CreateEndpointGroupInput = struct {
    /// The list of endpoint objects.
    endpoint_configurations: ?[]const EndpointConfiguration = null,

    /// The Amazon Web Services Region where the endpoint group is located. A
    /// listener can have only one endpoint group in a
    /// specific Region.
    endpoint_group_region: []const u8,

    /// The time—10 seconds or 30 seconds—between each health check for an endpoint.
    /// The default value is 30.
    health_check_interval_seconds: ?i32 = null,

    /// If the protocol is HTTP/S, then this specifies the path that is the
    /// destination for health check targets. The
    /// default value is slash (/).
    health_check_path: ?[]const u8 = null,

    /// The port that Global Accelerator uses to check the health of endpoints that
    /// are part of this endpoint group. The default port
    /// is the listener port that this endpoint group is associated with. If
    /// listener port is a list of ports, Global Accelerator uses the
    /// first port in the list.
    health_check_port: ?i32 = null,

    /// The protocol that Global Accelerator uses to check the health of endpoints
    /// that are part of this endpoint group. The default
    /// value is TCP.
    health_check_protocol: ?HealthCheckProtocol = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency—that is, the
    /// uniqueness—of the request.
    idempotency_token: []const u8,

    /// The Amazon Resource Name (ARN) of the listener.
    listener_arn: []const u8,

    /// Override specific listener ports used to route traffic to endpoints that are
    /// part of this endpoint group.
    /// For example, you can create a port override in which the listener
    /// receives user traffic on ports 80 and 443, but your accelerator routes that
    /// traffic to ports 1080
    /// and 1443, respectively, on the endpoints.
    ///
    /// For more information, see [
    /// Overriding listener
    /// ports](https://docs.aws.amazon.com/global-accelerator/latest/dg/about-endpoint-groups-port-override.html) in the *Global Accelerator Developer Guide*.
    port_overrides: ?[]const PortOverride = null,

    /// The number of consecutive health checks required to set the state of a
    /// healthy endpoint to unhealthy, or to set an
    /// unhealthy endpoint to healthy. The default value is 3.
    threshold_count: ?i32 = null,

    /// The percentage of traffic to send to an Amazon Web Services Region.
    /// Additional traffic is distributed to other endpoint groups for
    /// this listener.
    ///
    /// Use this action to increase (dial up) or decrease (dial down) traffic to a
    /// specific Region. The percentage is
    /// applied to the traffic that would otherwise have been routed to the Region
    /// based on optimal routing.
    ///
    /// The default value is 100.
    traffic_dial_percentage: ?f32 = null,

    pub const json_field_names = .{
        .endpoint_configurations = "EndpointConfigurations",
        .endpoint_group_region = "EndpointGroupRegion",
        .health_check_interval_seconds = "HealthCheckIntervalSeconds",
        .health_check_path = "HealthCheckPath",
        .health_check_port = "HealthCheckPort",
        .health_check_protocol = "HealthCheckProtocol",
        .idempotency_token = "IdempotencyToken",
        .listener_arn = "ListenerArn",
        .port_overrides = "PortOverrides",
        .threshold_count = "ThresholdCount",
        .traffic_dial_percentage = "TrafficDialPercentage",
    };
};

pub const CreateEndpointGroupOutput = struct {
    /// The information about the endpoint group that was created.
    endpoint_group: ?EndpointGroup = null,

    pub const json_field_names = .{
        .endpoint_group = "EndpointGroup",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEndpointGroupInput, options: Options) !CreateEndpointGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "globalaccelerator");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateEndpointGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("globalaccelerator", "Global Accelerator", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "GlobalAccelerator_V20180706.CreateEndpointGroup");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateEndpointGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateEndpointGroupOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AcceleratorNotDisabledException")) {
        return .{ .arena = arena, .kind = .{ .accelerator_not_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AcceleratorNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .accelerator_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AssociatedEndpointGroupFoundException")) {
        return .{ .arena = arena, .kind = .{ .associated_endpoint_group_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AssociatedListenerFoundException")) {
        return .{ .arena = arena, .kind = .{ .associated_listener_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AttachmentNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .attachment_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ByoipCidrNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .byoip_cidr_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .endpoint_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointGroupAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .endpoint_group_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointGroupNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .endpoint_group_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .endpoint_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncorrectCidrStateException")) {
        return .{ .arena = arena, .kind = .{ .incorrect_cidr_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArgumentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPortRangeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_port_range_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "TransactionInProgressException")) {
        return .{ .arena = arena, .kind = .{ .transaction_in_progress_exception = .{
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
