const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        already_exists_exception: AlreadyExistsException,
        client_token_conflict_exception: ClientTokenConflictException,
        concurrent_modification_exception: ConcurrentModificationException,
        concurrent_operation_exception: ConcurrentOperationException,
        general_service_exception: GeneralServiceException,
        handler_failure_exception: HandlerFailureException,
        handler_internal_failure_exception: HandlerInternalFailureException,
        invalid_credentials_exception: InvalidCredentialsException,
        invalid_request_exception: InvalidRequestException,
        network_failure_exception: NetworkFailureException,
        not_stabilized_exception: NotStabilizedException,
        not_updatable_exception: NotUpdatableException,
        private_type_exception: PrivateTypeException,
        request_token_not_found_exception: RequestTokenNotFoundException,
        resource_conflict_exception: ResourceConflictException,
        resource_not_found_exception: ResourceNotFoundException,
        service_internal_error_exception: ServiceInternalErrorException,
        service_limit_exceeded_exception: ServiceLimitExceededException,
        throttling_exception: ThrottlingException,
        type_not_found_exception: TypeNotFoundException,
        unsupported_action_exception: UnsupportedActionException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .already_exists_exception => "AlreadyExistsException",
                .client_token_conflict_exception => "ClientTokenConflictException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .concurrent_operation_exception => "ConcurrentOperationException",
                .general_service_exception => "GeneralServiceException",
                .handler_failure_exception => "HandlerFailureException",
                .handler_internal_failure_exception => "HandlerInternalFailureException",
                .invalid_credentials_exception => "InvalidCredentialsException",
                .invalid_request_exception => "InvalidRequestException",
                .network_failure_exception => "NetworkFailureException",
                .not_stabilized_exception => "NotStabilizedException",
                .not_updatable_exception => "NotUpdatableException",
                .private_type_exception => "PrivateTypeException",
                .request_token_not_found_exception => "RequestTokenNotFoundException",
                .resource_conflict_exception => "ResourceConflictException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_internal_error_exception => "ServiceInternalErrorException",
                .service_limit_exceeded_exception => "ServiceLimitExceededException",
                .throttling_exception => "ThrottlingException",
                .type_not_found_exception => "TypeNotFoundException",
                .unsupported_action_exception => "UnsupportedActionException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .already_exists_exception => |e| e.message,
                .client_token_conflict_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .concurrent_operation_exception => |e| e.message,
                .general_service_exception => |e| e.message,
                .handler_failure_exception => |e| e.message,
                .handler_internal_failure_exception => |e| e.message,
                .invalid_credentials_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .network_failure_exception => |e| e.message,
                .not_stabilized_exception => |e| e.message,
                .not_updatable_exception => |e| e.message,
                .private_type_exception => |e| e.message,
                .request_token_not_found_exception => |e| e.message,
                .resource_conflict_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_internal_error_exception => |e| e.message,
                .service_limit_exceeded_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .type_not_found_exception => |e| e.message,
                .unsupported_action_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .already_exists_exception => 400,
                .client_token_conflict_exception => 409,
                .concurrent_modification_exception => 500,
                .concurrent_operation_exception => 409,
                .general_service_exception => 400,
                .handler_failure_exception => 502,
                .handler_internal_failure_exception => 502,
                .invalid_credentials_exception => 401,
                .invalid_request_exception => 400,
                .network_failure_exception => 502,
                .not_stabilized_exception => 400,
                .not_updatable_exception => 400,
                .private_type_exception => 400,
                .request_token_not_found_exception => 404,
                .resource_conflict_exception => 409,
                .resource_not_found_exception => 404,
                .service_internal_error_exception => 502,
                .service_limit_exceeded_exception => 400,
                .throttling_exception => 429,
                .type_not_found_exception => 404,
                .unsupported_action_exception => 405,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .already_exists_exception => |e| e.request_id,
                .client_token_conflict_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .concurrent_operation_exception => |e| e.request_id,
                .general_service_exception => |e| e.request_id,
                .handler_failure_exception => |e| e.request_id,
                .handler_internal_failure_exception => |e| e.request_id,
                .invalid_credentials_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .network_failure_exception => |e| e.request_id,
                .not_stabilized_exception => |e| e.request_id,
                .not_updatable_exception => |e| e.request_id,
                .private_type_exception => |e| e.request_id,
                .request_token_not_found_exception => |e| e.request_id,
                .resource_conflict_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_internal_error_exception => |e| e.request_id,
                .service_limit_exceeded_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .type_not_found_exception => |e| e.request_id,
                .unsupported_action_exception => |e| e.request_id,
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

/// The resource with the name requested already exists.
pub const AlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified client token has already been used in another resource
/// request.
///
/// It's best practice for client tokens to be unique for each resource
/// operation request.
/// However, client token expire after 36 hours.
pub const ClientTokenConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource is currently being modified by another operation.
pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Another resource operation is currently being performed on this resource.
pub const ConcurrentOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource handler has returned that the downstream service generated an
/// error that
/// doesn't map to any other handler error code.
pub const GeneralServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource handler has failed without a returning a more specific error
/// code. This can
/// include timeouts.
pub const HandlerFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource handler has returned that an unexpected error occurred within
/// the resource
/// handler.
pub const HandlerInternalFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource handler has returned that the credentials provided by the user
/// are
/// invalid.
pub const InvalidCredentialsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource handler has returned that invalid input from the user has
/// generated a generic
/// exception.
pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource handler has returned that the request couldn't be completed due
/// to networking
/// issues, such as a failure to receive a response from the server.
pub const NetworkFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource handler has returned that the downstream resource failed to
/// complete all of
/// its ready-state checks.
pub const NotStabilizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// One or more properties included in this resource operation are defined as
/// create-only, and
/// therefore can't be updated.
pub const NotUpdatableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Cloud Control API hasn't received a valid response from the resource
/// handler, due to a configuration
/// error. This includes issues such as the resource handler returning an
/// invalid response, or
/// timing out.
pub const PrivateTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A resource operation with the specified request token can't be found.
pub const RequestTokenNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource is temporarily unavailable to be acted upon. For example, if
/// the resource is
/// currently undergoing an operation and can't be acted upon until that
/// operation is
/// finished.
pub const ResourceConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A resource with the specified identifier can't be found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource handler has returned that the downstream service returned an
/// internal error,
/// typically with a `5XX HTTP` status code.
pub const ServiceInternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource handler has returned that a non-transient resource limit was
/// reached on the
/// service side.
pub const ServiceLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was denied due to request throttling.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified extension doesn't exist in the CloudFormation registry.
pub const TypeNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified resource doesn't support this resource operation.
pub const UnsupportedActionException = struct {
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

    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        const parsed_error: ?AlreadyExistsException = aws.json.parseJsonObject(AlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ClientTokenConflictException")) {
        const parsed_error: ?ClientTokenConflictException = aws.json.parseJsonObject(ClientTokenConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .client_token_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        const parsed_error: ?ConcurrentModificationException = aws.json.parseJsonObject(ConcurrentModificationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConcurrentOperationException")) {
        const parsed_error: ?ConcurrentOperationException = aws.json.parseJsonObject(ConcurrentOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "GeneralServiceException")) {
        const parsed_error: ?GeneralServiceException = aws.json.parseJsonObject(GeneralServiceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .general_service_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "HandlerFailureException")) {
        const parsed_error: ?HandlerFailureException = aws.json.parseJsonObject(HandlerFailureException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .handler_failure_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "HandlerInternalFailureException")) {
        const parsed_error: ?HandlerInternalFailureException = aws.json.parseJsonObject(HandlerInternalFailureException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .handler_internal_failure_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidCredentialsException")) {
        const parsed_error: ?InvalidCredentialsException = aws.json.parseJsonObject(InvalidCredentialsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_credentials_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        const parsed_error: ?InvalidRequestException = aws.json.parseJsonObject(InvalidRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NetworkFailureException")) {
        const parsed_error: ?NetworkFailureException = aws.json.parseJsonObject(NetworkFailureException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .network_failure_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NotStabilizedException")) {
        const parsed_error: ?NotStabilizedException = aws.json.parseJsonObject(NotStabilizedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_stabilized_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NotUpdatableException")) {
        const parsed_error: ?NotUpdatableException = aws.json.parseJsonObject(NotUpdatableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_updatable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PrivateTypeException")) {
        const parsed_error: ?PrivateTypeException = aws.json.parseJsonObject(PrivateTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .private_type_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RequestTokenNotFoundException")) {
        const parsed_error: ?RequestTokenNotFoundException = aws.json.parseJsonObject(RequestTokenNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .request_token_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceConflictException")) {
        const parsed_error: ?ResourceConflictException = aws.json.parseJsonObject(ResourceConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?ResourceNotFoundException = aws.json.parseJsonObject(ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceInternalErrorException")) {
        const parsed_error: ?ServiceInternalErrorException = aws.json.parseJsonObject(ServiceInternalErrorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_internal_error_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceLimitExceededException")) {
        const parsed_error: ?ServiceLimitExceededException = aws.json.parseJsonObject(ServiceLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?ThrottlingException = aws.json.parseJsonObject(ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TypeNotFoundException")) {
        const parsed_error: ?TypeNotFoundException = aws.json.parseJsonObject(TypeNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .type_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedActionException")) {
        const parsed_error: ?UnsupportedActionException = aws.json.parseJsonObject(UnsupportedActionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_action_exception = typed_error } };
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
