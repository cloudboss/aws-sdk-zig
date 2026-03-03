const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ClientAffinity = @import("client_affinity.zig").ClientAffinity;
const PortRange = @import("port_range.zig").PortRange;
const Protocol = @import("protocol.zig").Protocol;
const Listener = @import("listener.zig").Listener;

pub const CreateListenerInput = struct {
    /// The Amazon Resource Name (ARN) of your accelerator.
    accelerator_arn: []const u8,

    /// Client affinity lets you direct all requests from a user to the same
    /// endpoint, if you have stateful applications,
    /// regardless of the port and protocol of the client request. Client affinity
    /// gives you control over whether to always
    /// route each client to the same specific endpoint.
    ///
    /// Global Accelerator uses a consistent-flow hashing algorithm to choose the
    /// optimal endpoint for a connection. If client
    /// affinity is `NONE`, Global Accelerator uses the "five-tuple" (5-tuple)
    /// properties—source IP address, source port,
    /// destination IP address, destination port, and protocol—to select the hash
    /// value, and then chooses the best
    /// endpoint. However, with this setting, if someone uses different ports to
    /// connect to Global Accelerator, their connections might not
    /// be always routed to the same endpoint because the hash value changes.
    ///
    /// If you want a given client to always be routed to the same endpoint, set
    /// client affinity to `SOURCE_IP`
    /// instead. When you use the `SOURCE_IP` setting, Global Accelerator uses the
    /// "two-tuple" (2-tuple) properties—
    /// source (client) IP address and destination IP address—to select the hash
    /// value.
    ///
    /// The default value is `NONE`.
    client_affinity: ?ClientAffinity = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency—that is, the
    /// uniqueness—of the request.
    idempotency_token: []const u8,

    /// The list of port ranges to support for connections from clients to your
    /// accelerator.
    port_ranges: []const PortRange,

    /// The protocol for connections from clients to your accelerator.
    protocol: Protocol,

    pub const json_field_names = .{
        .accelerator_arn = "AcceleratorArn",
        .client_affinity = "ClientAffinity",
        .idempotency_token = "IdempotencyToken",
        .port_ranges = "PortRanges",
        .protocol = "Protocol",
    };
};

pub const CreateListenerOutput = struct {
    /// The listener that you've created.
    listener: ?Listener = null,

    pub const json_field_names = .{
        .listener = "Listener",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateListenerInput, options: Options) !CreateListenerOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateListenerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("globalaccelerator", "Global Accelerator", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GlobalAccelerator_V20180706.CreateListener");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateListenerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateListenerOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
