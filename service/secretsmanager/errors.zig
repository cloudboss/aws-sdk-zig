const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        decryption_failure: DecryptionFailure,
        encryption_failure: EncryptionFailure,
        internal_service_error: InternalServiceError,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_request_exception: InvalidRequestException,
        limit_exceeded_exception: LimitExceededException,
        malformed_policy_document_exception: MalformedPolicyDocumentException,
        precondition_not_met_exception: PreconditionNotMetException,
        public_policy_exception: PublicPolicyException,
        resource_exists_exception: ResourceExistsException,
        resource_not_found_exception: ResourceNotFoundException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .decryption_failure => "DecryptionFailure",
                .encryption_failure => "EncryptionFailure",
                .internal_service_error => "InternalServiceError",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_request_exception => "InvalidRequestException",
                .limit_exceeded_exception => "LimitExceededException",
                .malformed_policy_document_exception => "MalformedPolicyDocumentException",
                .precondition_not_met_exception => "PreconditionNotMetException",
                .public_policy_exception => "PublicPolicyException",
                .resource_exists_exception => "ResourceExistsException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .decryption_failure => |e| e.message,
                .encryption_failure => |e| e.message,
                .internal_service_error => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .malformed_policy_document_exception => |e| e.message,
                .precondition_not_met_exception => |e| e.message,
                .public_policy_exception => |e| e.message,
                .resource_exists_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .decryption_failure => 400,
                .encryption_failure => 400,
                .internal_service_error => 500,
                .invalid_next_token_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_request_exception => 400,
                .limit_exceeded_exception => 400,
                .malformed_policy_document_exception => 400,
                .precondition_not_met_exception => 400,
                .public_policy_exception => 400,
                .resource_exists_exception => 400,
                .resource_not_found_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .decryption_failure => |e| e.request_id,
                .encryption_failure => |e| e.request_id,
                .internal_service_error => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .malformed_policy_document_exception => |e| e.request_id,
                .precondition_not_met_exception => |e| e.request_id,
                .public_policy_exception => |e| e.request_id,
                .resource_exists_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
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

/// Secrets Manager can't decrypt the protected secret text using the provided
/// KMS key.
pub const DecryptionFailure = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Secrets Manager can't encrypt the protected secret text using the provided
/// KMS key. Check that the
/// KMS key is available, enabled, and not in an invalid state. For more
/// information, see [Key state: Effect on your KMS
/// key](https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html).
pub const EncryptionFailure = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An error occurred on the server side.
pub const InternalServiceError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The `NextToken` value is invalid.
pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The parameter name or value is invalid.
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A parameter value is not valid for the current state of the
/// resource.
///
/// Possible causes:
///
/// * The secret is scheduled for deletion.
///
/// * You tried to enable rotation on a secret that doesn't already have a
///   Lambda function
/// ARN configured and you didn't include such an ARN as a parameter in this
/// call.
///
/// * The secret is managed by another service, and you must use that service to
///   update it.
/// For more information, see [Secrets managed by other Amazon Web Services
/// services](https://docs.aws.amazon.com/secretsmanager/latest/userguide/service-linked-secrets.html).
pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request failed because it would exceed one of the Secrets Manager
/// quotas.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource policy has syntax errors.
pub const MalformedPolicyDocumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request failed because you did not complete all the prerequisite steps.
pub const PreconditionNotMetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The `BlockPublicPolicy` parameter is set to true, and the resource policy
/// did not prevent broad access to the secret.
pub const PublicPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A resource with the ID you requested already exists.
pub const ResourceExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Secrets Manager can't find the resource that you asked for.
pub const ResourceNotFoundException = struct {
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

    if (std.mem.eql(u8, error_code, "DecryptionFailure")) {
        const parsed_error: ?DecryptionFailure = aws.json.parseJsonObject(DecryptionFailure, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .decryption_failure = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EncryptionFailure")) {
        const parsed_error: ?EncryptionFailure = aws.json.parseJsonObject(EncryptionFailure, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .encryption_failure = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        const parsed_error: ?InternalServiceError = aws.json.parseJsonObject(InternalServiceError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_service_error = typed_error } };
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
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        const parsed_error: ?InvalidParameterException = aws.json.parseJsonObject(InvalidParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        const parsed_error: ?MalformedPolicyDocumentException = aws.json.parseJsonObject(MalformedPolicyDocumentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .malformed_policy_document_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PreconditionNotMetException")) {
        const parsed_error: ?PreconditionNotMetException = aws.json.parseJsonObject(PreconditionNotMetException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .precondition_not_met_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PublicPolicyException")) {
        const parsed_error: ?PublicPolicyException = aws.json.parseJsonObject(PublicPolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .public_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        const parsed_error: ?ResourceExistsException = aws.json.parseJsonObject(ResourceExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_exists_exception = typed_error } };
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
