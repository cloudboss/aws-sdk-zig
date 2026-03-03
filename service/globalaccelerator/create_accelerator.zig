const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const Tag = @import("tag.zig").Tag;
const Accelerator = @import("accelerator.zig").Accelerator;

pub const CreateAcceleratorInput = struct {
    /// Indicates whether an accelerator is enabled. The value is true or false. The
    /// default value is true.
    ///
    /// If the value is set to true, an accelerator cannot be deleted. If set to
    /// false, the accelerator can be deleted.
    enabled: ?bool = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency—that is, the
    /// uniqueness—of an accelerator.
    idempotency_token: []const u8,

    /// Optionally, if you've added your own IP address pool to Global Accelerator
    /// (BYOIP), you can choose an IPv4 address
    /// from your own pool to use for the accelerator's static IPv4 address when you
    /// create an accelerator.
    ///
    /// After you bring an address range to Amazon Web Services, it appears in your
    /// account as an address pool.
    /// When you create an accelerator, you can assign one IPv4 address from your
    /// range to it. Global Accelerator assigns
    /// you a second static IPv4 address from an Amazon IP address range. If you
    /// bring two IPv4 address ranges
    /// to Amazon Web Services, you can assign one IPv4 address from each range to
    /// your accelerator. This restriction is
    /// because Global Accelerator assigns each address range to a different network
    /// zone, for high availability.
    ///
    /// You can specify one or two addresses, separated by a space. Do not include
    /// the /32 suffix.
    ///
    /// Note that you can't update IP addresses for an existing accelerator. To
    /// change them, you must create a new
    /// accelerator with the new addresses.
    ///
    /// For more information, see [Bring
    /// your own IP addresses
    /// (BYOIP)](https://docs.aws.amazon.com/global-accelerator/latest/dg/using-byoip.html) in the *Global Accelerator Developer Guide*.
    ip_addresses: ?[]const []const u8 = null,

    /// The IP address type that an accelerator supports. For a standard
    /// accelerator, the value can be IPV4 or DUAL_STACK.
    ip_address_type: ?IpAddressType = null,

    /// The name of the accelerator. The name can have a maximum of 64 characters,
    /// must contain only alphanumeric characters,
    /// periods (.), or hyphens (-), and must not begin or end with a hyphen or
    /// period.
    name: []const u8,

    /// Create tags for an accelerator.
    ///
    /// For more information, see [Tagging
    /// in Global
    /// Accelerator](https://docs.aws.amazon.com/global-accelerator/latest/dg/tagging-in-global-accelerator.html) in the *Global Accelerator Developer Guide*.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .idempotency_token = "IdempotencyToken",
        .ip_addresses = "IpAddresses",
        .ip_address_type = "IpAddressType",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateAcceleratorOutput = struct {
    /// The accelerator that is created by specifying a listener and the supported
    /// IP address types.
    accelerator: ?Accelerator = null,

    pub const json_field_names = .{
        .accelerator = "Accelerator",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAcceleratorInput, options: CallOptions) !CreateAcceleratorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAcceleratorInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GlobalAccelerator_V20180706.CreateAccelerator");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAcceleratorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAcceleratorOutput, body, allocator);
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
