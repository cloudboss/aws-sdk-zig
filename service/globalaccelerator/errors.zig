const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        accelerator_not_disabled_exception: AcceleratorNotDisabledException,
        accelerator_not_found_exception: AcceleratorNotFoundException,
        access_denied_exception: AccessDeniedException,
        associated_endpoint_group_found_exception: AssociatedEndpointGroupFoundException,
        associated_listener_found_exception: AssociatedListenerFoundException,
        attachment_not_found_exception: AttachmentNotFoundException,
        byoip_cidr_not_found_exception: ByoipCidrNotFoundException,
        conflict_exception: ConflictException,
        endpoint_already_exists_exception: EndpointAlreadyExistsException,
        endpoint_group_already_exists_exception: EndpointGroupAlreadyExistsException,
        endpoint_group_not_found_exception: EndpointGroupNotFoundException,
        endpoint_not_found_exception: EndpointNotFoundException,
        incorrect_cidr_state_exception: IncorrectCidrStateException,
        internal_service_error_exception: InternalServiceErrorException,
        invalid_argument_exception: InvalidArgumentException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_port_range_exception: InvalidPortRangeException,
        limit_exceeded_exception: LimitExceededException,
        listener_not_found_exception: ListenerNotFoundException,
        transaction_in_progress_exception: TransactionInProgressException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .accelerator_not_disabled_exception => "AcceleratorNotDisabledException",
                .accelerator_not_found_exception => "AcceleratorNotFoundException",
                .access_denied_exception => "AccessDeniedException",
                .associated_endpoint_group_found_exception => "AssociatedEndpointGroupFoundException",
                .associated_listener_found_exception => "AssociatedListenerFoundException",
                .attachment_not_found_exception => "AttachmentNotFoundException",
                .byoip_cidr_not_found_exception => "ByoipCidrNotFoundException",
                .conflict_exception => "ConflictException",
                .endpoint_already_exists_exception => "EndpointAlreadyExistsException",
                .endpoint_group_already_exists_exception => "EndpointGroupAlreadyExistsException",
                .endpoint_group_not_found_exception => "EndpointGroupNotFoundException",
                .endpoint_not_found_exception => "EndpointNotFoundException",
                .incorrect_cidr_state_exception => "IncorrectCidrStateException",
                .internal_service_error_exception => "InternalServiceErrorException",
                .invalid_argument_exception => "InvalidArgumentException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_port_range_exception => "InvalidPortRangeException",
                .limit_exceeded_exception => "LimitExceededException",
                .listener_not_found_exception => "ListenerNotFoundException",
                .transaction_in_progress_exception => "TransactionInProgressException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .accelerator_not_disabled_exception => |e| e.message,
                .accelerator_not_found_exception => |e| e.message,
                .access_denied_exception => |e| e.message,
                .associated_endpoint_group_found_exception => |e| e.message,
                .associated_listener_found_exception => |e| e.message,
                .attachment_not_found_exception => |e| e.message,
                .byoip_cidr_not_found_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .endpoint_already_exists_exception => |e| e.message,
                .endpoint_group_already_exists_exception => |e| e.message,
                .endpoint_group_not_found_exception => |e| e.message,
                .endpoint_not_found_exception => |e| e.message,
                .incorrect_cidr_state_exception => |e| e.message,
                .internal_service_error_exception => |e| e.message,
                .invalid_argument_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_port_range_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .listener_not_found_exception => |e| e.message,
                .transaction_in_progress_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .accelerator_not_disabled_exception => 400,
                .accelerator_not_found_exception => 404,
                .access_denied_exception => 403,
                .associated_endpoint_group_found_exception => 400,
                .associated_listener_found_exception => 400,
                .attachment_not_found_exception => 404,
                .byoip_cidr_not_found_exception => 404,
                .conflict_exception => 409,
                .endpoint_already_exists_exception => 400,
                .endpoint_group_already_exists_exception => 400,
                .endpoint_group_not_found_exception => 404,
                .endpoint_not_found_exception => 404,
                .incorrect_cidr_state_exception => 404,
                .internal_service_error_exception => 500,
                .invalid_argument_exception => 400,
                .invalid_next_token_exception => 400,
                .invalid_port_range_exception => 400,
                .limit_exceeded_exception => 403,
                .listener_not_found_exception => 404,
                .transaction_in_progress_exception => 409,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .accelerator_not_disabled_exception => |e| e.request_id,
                .accelerator_not_found_exception => |e| e.request_id,
                .access_denied_exception => |e| e.request_id,
                .associated_endpoint_group_found_exception => |e| e.request_id,
                .associated_listener_found_exception => |e| e.request_id,
                .attachment_not_found_exception => |e| e.request_id,
                .byoip_cidr_not_found_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .endpoint_already_exists_exception => |e| e.request_id,
                .endpoint_group_already_exists_exception => |e| e.request_id,
                .endpoint_group_not_found_exception => |e| e.request_id,
                .endpoint_not_found_exception => |e| e.request_id,
                .incorrect_cidr_state_exception => |e| e.request_id,
                .internal_service_error_exception => |e| e.request_id,
                .invalid_argument_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_port_range_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .listener_not_found_exception => |e| e.request_id,
                .transaction_in_progress_exception => |e| e.request_id,
                .unknown => |e| e.request_id,
            };
        }
    };

    pub fn deinit(self: *ServiceError) void {
        if (self.arena) |*a| a.deinit();
    }

    pub fn code(self: ServiceError) []const u8 {
        return self.kind.code();
    }

    pub fn message(self: ServiceError) []const u8 {
        return self.kind.message();
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return self.kind.httpStatus();
    }

    pub fn requestId(self: ServiceError) []const u8 {
        return self.kind.requestId();
    }
};

/// The accelerator that you specified could not be disabled.
pub const AcceleratorNotDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The accelerator that you specified doesn't exist.
pub const AcceleratorNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You don't have access permission.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The listener that you specified has an endpoint group associated with it.
/// You must remove all dependent resources
/// from a listener before you can delete it.
pub const AssociatedEndpointGroupFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The accelerator that you specified has a listener associated with it. You
/// must remove all dependent resources from an
/// accelerator before you can delete it.
pub const AssociatedListenerFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// No cross-account attachment was found.
pub const AttachmentNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The CIDR that you specified was not found or is incorrect.
pub const ByoipCidrNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You can't use both of those options.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The endpoint that you specified doesn't exist.
pub const EndpointAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The endpoint group that you specified already exists.
pub const EndpointGroupAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The endpoint group that you specified doesn't exist.
pub const EndpointGroupNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The endpoint that you specified doesn't exist.
pub const EndpointNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The CIDR that you specified is not valid for this action. For example, the
/// state of the CIDR might be
/// incorrect for this action.
pub const IncorrectCidrStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// There was an internal error for Global Accelerator.
pub const InternalServiceErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An argument that you specified is invalid.
pub const InvalidArgumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// There isn't another item to return.
pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The port numbers that you specified are not valid numbers or are not unique
/// for this accelerator.
pub const InvalidPortRangeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Processing your request would cause you to exceed an Global Accelerator
/// limit.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The listener that you specified doesn't exist.
pub const ListenerNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// There's already a transaction in progress. Another transaction can't be
/// processed.
pub const TransactionInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};

/// Parse a service diagnostic. The caller must call deinit on the result.
pub fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) std.mem.Allocator.Error!ServiceError {
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
        const parsed_error: ?AcceleratorNotDisabledException = aws.json.parseJsonObject(AcceleratorNotDisabledException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?AcceleratorNotFoundException = aws.json.parseJsonObject(AcceleratorNotFoundException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?AccessDeniedException = aws.json.parseJsonObject(AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?AssociatedEndpointGroupFoundException = aws.json.parseJsonObject(AssociatedEndpointGroupFoundException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?AssociatedListenerFoundException = aws.json.parseJsonObject(AssociatedListenerFoundException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?AttachmentNotFoundException = aws.json.parseJsonObject(AttachmentNotFoundException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?ByoipCidrNotFoundException = aws.json.parseJsonObject(ByoipCidrNotFoundException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?ConflictException = aws.json.parseJsonObject(ConflictException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?EndpointAlreadyExistsException = aws.json.parseJsonObject(EndpointAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?EndpointGroupAlreadyExistsException = aws.json.parseJsonObject(EndpointGroupAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?EndpointGroupNotFoundException = aws.json.parseJsonObject(EndpointGroupNotFoundException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?EndpointNotFoundException = aws.json.parseJsonObject(EndpointNotFoundException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?IncorrectCidrStateException = aws.json.parseJsonObject(IncorrectCidrStateException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InternalServiceErrorException = aws.json.parseJsonObject(InternalServiceErrorException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InvalidArgumentException = aws.json.parseJsonObject(InvalidArgumentException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InvalidNextTokenException = aws.json.parseJsonObject(InvalidNextTokenException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InvalidPortRangeException = aws.json.parseJsonObject(InvalidPortRangeException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?LimitExceededException = aws.json.parseJsonObject(LimitExceededException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?ListenerNotFoundException = aws.json.parseJsonObject(ListenerNotFoundException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?TransactionInProgressException = aws.json.parseJsonObject(TransactionInProgressException, body, arena_alloc) catch |err| switch (err) {
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
