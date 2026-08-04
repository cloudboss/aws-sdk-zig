const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
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

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "globalaccelerator", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAcceleratorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("globalaccelerator", "Global Accelerator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.AcceleratorNotDisabledException = aws.json.parseJsonObject(errors.AcceleratorNotDisabledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .accelerator_not_disabled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AcceleratorNotFoundException")) {
        const parsed_error: ?errors.AcceleratorNotFoundException = aws.json.parseJsonObject(errors.AcceleratorNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .accelerator_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociatedEndpointGroupFoundException")) {
        const parsed_error: ?errors.AssociatedEndpointGroupFoundException = aws.json.parseJsonObject(errors.AssociatedEndpointGroupFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .associated_endpoint_group_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociatedListenerFoundException")) {
        const parsed_error: ?errors.AssociatedListenerFoundException = aws.json.parseJsonObject(errors.AssociatedListenerFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .associated_listener_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AttachmentNotFoundException")) {
        const parsed_error: ?errors.AttachmentNotFoundException = aws.json.parseJsonObject(errors.AttachmentNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .attachment_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ByoipCidrNotFoundException")) {
        const parsed_error: ?errors.ByoipCidrNotFoundException = aws.json.parseJsonObject(errors.ByoipCidrNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .byoip_cidr_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EndpointAlreadyExistsException")) {
        const parsed_error: ?errors.EndpointAlreadyExistsException = aws.json.parseJsonObject(errors.EndpointAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .endpoint_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EndpointGroupAlreadyExistsException")) {
        const parsed_error: ?errors.EndpointGroupAlreadyExistsException = aws.json.parseJsonObject(errors.EndpointGroupAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .endpoint_group_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EndpointGroupNotFoundException")) {
        const parsed_error: ?errors.EndpointGroupNotFoundException = aws.json.parseJsonObject(errors.EndpointGroupNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .endpoint_group_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EndpointNotFoundException")) {
        const parsed_error: ?errors.EndpointNotFoundException = aws.json.parseJsonObject(errors.EndpointNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .endpoint_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IncorrectCidrStateException")) {
        const parsed_error: ?errors.IncorrectCidrStateException = aws.json.parseJsonObject(errors.IncorrectCidrStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .incorrect_cidr_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServiceErrorException")) {
        const parsed_error: ?errors.InternalServiceErrorException = aws.json.parseJsonObject(errors.InternalServiceErrorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_service_error_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidArgumentException")) {
        const parsed_error: ?errors.InvalidArgumentException = aws.json.parseJsonObject(errors.InvalidArgumentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_argument_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        const parsed_error: ?errors.InvalidNextTokenException = aws.json.parseJsonObject(errors.InvalidNextTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPortRangeException")) {
        const parsed_error: ?errors.InvalidPortRangeException = aws.json.parseJsonObject(errors.InvalidPortRangeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_port_range_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ListenerNotFoundException")) {
        const parsed_error: ?errors.ListenerNotFoundException = aws.json.parseJsonObject(errors.ListenerNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .listener_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TransactionInProgressException")) {
        const parsed_error: ?errors.TransactionInProgressException = aws.json.parseJsonObject(errors.TransactionInProgressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .transaction_in_progress_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
