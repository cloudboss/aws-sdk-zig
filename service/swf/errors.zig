const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        default_undefined_fault: DefaultUndefinedFault,
        domain_already_exists_fault: DomainAlreadyExistsFault,
        domain_deprecated_fault: DomainDeprecatedFault,
        limit_exceeded_fault: LimitExceededFault,
        operation_not_permitted_fault: OperationNotPermittedFault,
        too_many_tags_fault: TooManyTagsFault,
        type_already_exists_fault: TypeAlreadyExistsFault,
        type_deprecated_fault: TypeDeprecatedFault,
        type_not_deprecated_fault: TypeNotDeprecatedFault,
        unknown_resource_fault: UnknownResourceFault,
        workflow_execution_already_started_fault: WorkflowExecutionAlreadyStartedFault,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .default_undefined_fault => "DefaultUndefinedFault",
                .domain_already_exists_fault => "DomainAlreadyExistsFault",
                .domain_deprecated_fault => "DomainDeprecatedFault",
                .limit_exceeded_fault => "LimitExceededFault",
                .operation_not_permitted_fault => "OperationNotPermittedFault",
                .too_many_tags_fault => "TooManyTagsFault",
                .type_already_exists_fault => "TypeAlreadyExistsFault",
                .type_deprecated_fault => "TypeDeprecatedFault",
                .type_not_deprecated_fault => "TypeNotDeprecatedFault",
                .unknown_resource_fault => "UnknownResourceFault",
                .workflow_execution_already_started_fault => "WorkflowExecutionAlreadyStartedFault",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .default_undefined_fault => |e| e.message,
                .domain_already_exists_fault => |e| e.message,
                .domain_deprecated_fault => |e| e.message,
                .limit_exceeded_fault => |e| e.message,
                .operation_not_permitted_fault => |e| e.message,
                .too_many_tags_fault => |e| e.message,
                .type_already_exists_fault => |e| e.message,
                .type_deprecated_fault => |e| e.message,
                .type_not_deprecated_fault => |e| e.message,
                .unknown_resource_fault => |e| e.message,
                .workflow_execution_already_started_fault => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .default_undefined_fault => 400,
                .domain_already_exists_fault => 400,
                .domain_deprecated_fault => 400,
                .limit_exceeded_fault => 400,
                .operation_not_permitted_fault => 400,
                .too_many_tags_fault => 400,
                .type_already_exists_fault => 400,
                .type_deprecated_fault => 400,
                .type_not_deprecated_fault => 400,
                .unknown_resource_fault => 400,
                .workflow_execution_already_started_fault => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .default_undefined_fault => |e| e.request_id,
                .domain_already_exists_fault => |e| e.request_id,
                .domain_deprecated_fault => |e| e.request_id,
                .limit_exceeded_fault => |e| e.request_id,
                .operation_not_permitted_fault => |e| e.request_id,
                .too_many_tags_fault => |e| e.request_id,
                .type_already_exists_fault => |e| e.request_id,
                .type_deprecated_fault => |e| e.request_id,
                .type_not_deprecated_fault => |e| e.request_id,
                .unknown_resource_fault => |e| e.request_id,
                .workflow_execution_already_started_fault => |e| e.request_id,
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

/// The `StartWorkflowExecution` API action was called without the required
/// parameters set.
///
/// Some workflow execution parameters, such as the decision `taskList`, must be
/// set to start the execution. However, these parameters might have been set as
/// defaults when the
/// workflow type was registered. In this case, you can omit these parameters
/// from the
/// `StartWorkflowExecution` call and Amazon SWF uses the values defined in the
/// workflow
/// type.
///
/// If these parameters aren't set and no default parameters were defined in the
/// workflow
/// type, this error is displayed.
pub const DefaultUndefinedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Returned if the domain already exists. You may get this fault if you are
/// registering a domain that is either already registered or deprecated, or if
/// you undeprecate a domain that is currently registered.
pub const DomainAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Returned when the specified domain has been deprecated.
pub const DomainDeprecatedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Returned by any operation if a system imposed limitation has been reached.
/// To address this fault you should either clean up unused resources or
/// increase the limit by contacting AWS.
pub const LimitExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Returned when the caller doesn't have sufficient permissions to invoke the
/// action.
pub const OperationNotPermittedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You've exceeded the number of tags allowed for a domain.
pub const TooManyTagsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Returned if the type already exists in the specified domain. You may get
/// this fault if you are registering a type that is either already registered
/// or deprecated, or if you undeprecate a type that is currently registered.
pub const TypeAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Returned when the specified activity or workflow type was already
/// deprecated.
pub const TypeDeprecatedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Returned when the resource type has not been deprecated.
pub const TypeNotDeprecatedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Returned when the named resource cannot be found with in the scope of this
/// operation (region or domain). This could happen if the named resource was
/// never created or is no longer available for this operation.
pub const UnknownResourceFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Returned by StartWorkflowExecution when an open execution with the same
/// workflowId is already running in
/// the specified domain.
pub const WorkflowExecutionAlreadyStartedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
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

    if (std.mem.eql(u8, error_code, "DefaultUndefinedFault")) {
        const parsed_error: ?DefaultUndefinedFault = aws.json.parseJsonObject(DefaultUndefinedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .default_undefined_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DomainAlreadyExistsFault")) {
        const parsed_error: ?DomainAlreadyExistsFault = aws.json.parseJsonObject(DomainAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .domain_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DomainDeprecatedFault")) {
        const parsed_error: ?DomainDeprecatedFault = aws.json.parseJsonObject(DomainDeprecatedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .domain_deprecated_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        const parsed_error: ?LimitExceededFault = aws.json.parseJsonObject(LimitExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OperationNotPermittedFault")) {
        const parsed_error: ?OperationNotPermittedFault = aws.json.parseJsonObject(OperationNotPermittedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_not_permitted_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsFault")) {
        const parsed_error: ?TooManyTagsFault = aws.json.parseJsonObject(TooManyTagsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TypeAlreadyExistsFault")) {
        const parsed_error: ?TypeAlreadyExistsFault = aws.json.parseJsonObject(TypeAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .type_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TypeDeprecatedFault")) {
        const parsed_error: ?TypeDeprecatedFault = aws.json.parseJsonObject(TypeDeprecatedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .type_deprecated_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TypeNotDeprecatedFault")) {
        const parsed_error: ?TypeNotDeprecatedFault = aws.json.parseJsonObject(TypeNotDeprecatedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .type_not_deprecated_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnknownResourceFault")) {
        const parsed_error: ?UnknownResourceFault = aws.json.parseJsonObject(UnknownResourceFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unknown_resource_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WorkflowExecutionAlreadyStartedFault")) {
        const parsed_error: ?WorkflowExecutionAlreadyStartedFault = aws.json.parseJsonObject(WorkflowExecutionAlreadyStartedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .workflow_execution_already_started_fault = typed_error } };
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
