const aws = @import("aws");
const std = @import("std");

const ResourceConflict = @import("resource_conflict.zig").ResourceConflict;
const ResourceType = @import("resource_type.zig").ResourceType;
const ValidationExceptionField = @import("validation_exception_field.zig").ValidationExceptionField;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        conflict_exception: ConflictException,
        internal_server_exception: InternalServerException,
        invalid_state_exception: InvalidStateException,
        resource_not_found_exception: ResourceNotFoundException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        throttling_exception: ThrottlingException,
        too_many_tags_exception: TooManyTagsException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .conflict_exception => "ConflictException",
                .internal_server_exception => "InternalServerException",
                .invalid_state_exception => "InvalidStateException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .throttling_exception => "ThrottlingException",
                .too_many_tags_exception => "TooManyTagsException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .invalid_state_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .conflict_exception => 409,
                .internal_server_exception => 500,
                .invalid_state_exception => 406,
                .resource_not_found_exception => 404,
                .service_quota_exceeded_exception => 402,
                .throttling_exception => 429,
                .too_many_tags_exception => 400,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .invalid_state_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
                .validation_exception => |e| e.request_id,
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

/// You don't have sufficient access to perform this action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request failed because another request to modify a resource occurred at
/// the same time.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The list of resources referenced with this failed request.
    resources: ?[]const ResourceConflict = null,

    pub const json_field_names = .{
        .message = "message",
        .resources = "resources",
    };
};

/// The request failed because of an internal error. Try your request again
/// later
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The policy store can't be deleted because deletion protection is enabled. To
/// delete this policy store, disable deletion protection.
pub const InvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request failed because it references a resource that doesn't exist.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The unique ID of the resource referenced in the failed request.
    resource_id: []const u8,

    /// The resource type of the resource referenced in the failed request.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .message = "message",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};

/// The request failed because it would cause a service quota to be exceeded.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The quota code recognized by the Amazon Web Services Service Quotas service.
    quota_code: ?[]const u8 = null,

    /// The unique ID of the resource referenced in the failed request.
    resource_id: ?[]const u8 = null,

    /// The resource type of the resource referenced in the failed request.
    resource_type: ?ResourceType = null,

    /// The code for the Amazon Web Services service that owns the quota.
    service_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .quota_code = "quotaCode",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
        .service_code = "serviceCode",
    };
};

/// The request failed because it exceeded a throttling quota.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The quota code recognized by the Amazon Web Services Service Quotas service.
    quota_code: ?[]const u8 = null,

    /// The code for the Amazon Web Services service that owns the quota.
    service_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .quota_code = "quotaCode",
        .service_code = "serviceCode",
    };
};

/// No more tags be added because the limit (50) has been reached. To add new
/// tags, use `UntagResource` to remove existing tags.
pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    resource_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .resource_name = "resourceName",
    };
};

/// The request failed because one or more input parameters don't satisfy their
/// constraint requirements. The output is provided as a list of fields and a
/// reason for each field that isn't valid.
///
/// The possible reasons include the following:
///
/// * **UnrecognizedEntityType**
///
/// The policy includes an entity type that isn't found in the schema.
/// * **UnrecognizedActionId**
///
/// The policy includes an action id that isn't found in the schema.
/// * **InvalidActionApplication**
///
/// The policy includes an action that, according to the schema, doesn't support
/// the specified principal and resource.
/// * **UnexpectedType**
///
/// The policy included an operand that isn't a valid type for the specified
/// operation.
/// * **IncompatibleTypes**
///
/// The types of elements included in a `set`, or the types of expressions used
/// in an `if...then...else` clause aren't compatible in this context.
/// * **MissingAttribute**
///
/// The policy attempts to access a record or entity attribute that isn't
/// specified in the schema. Test for the existence of the attribute first
/// before attempting to access its value. For more information, see the [has
/// (presence of attribute test)
/// operator](https://docs.cedarpolicy.com/policies/syntax-operators.html#has-presence-of-attribute-test) in the *Cedar Policy Language Guide*.
/// * **UnsafeOptionalAttributeAccess**
///
/// The policy attempts to access a record or entity attribute that is optional
/// and isn't guaranteed to be present. Test for the existence of the attribute
/// first before attempting to access its value. For more information, see the
/// [has (presence of attribute test)
/// operator](https://docs.cedarpolicy.com/policies/syntax-operators.html#has-presence-of-attribute-test) in the *Cedar Policy Language Guide*.
/// * **ImpossiblePolicy**
///
/// Cedar has determined that a policy condition always evaluates to false. If
/// the policy is always false, it can never apply to any query, and so it can
/// never affect an authorization decision.
/// * **WrongNumberArguments**
///
/// The policy references an extension type with the wrong number of arguments.
/// * **FunctionArgumentValidationError**
///
/// Cedar couldn't parse the argument passed to an extension type. For example,
/// a string that is to be parsed as an IPv4 address can contain only digits and
/// the period character.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The list of fields that aren't valid.
    field_list: ?[]const ValidationExceptionField = null,

    pub const json_field_names = .{
        .field_list = "fieldList",
        .message = "message",
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        const parsed_error: ?InternalServerException = aws.json.parseJsonObject(InternalServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        const parsed_error: ?InvalidStateException = aws.json.parseJsonObject(InvalidStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_state_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?ServiceQuotaExceededException = aws.json.parseJsonObject(ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        const parsed_error: ?TooManyTagsException = aws.json.parseJsonObject(TooManyTagsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?ValidationException = aws.json.parseJsonObject(ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
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
