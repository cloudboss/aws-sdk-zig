const aws = @import("aws");
const std = @import("std");

const AccessDeniedErrorCode = @import("access_denied_error_code.zig").AccessDeniedErrorCode;
const AgentAlreadyRunningAssessment = @import("agent_already_running_assessment.zig").AgentAlreadyRunningAssessment;
const InvalidCrossAccountRoleErrorCode = @import("invalid_cross_account_role_error_code.zig").InvalidCrossAccountRoleErrorCode;
const InvalidInputErrorCode = @import("invalid_input_error_code.zig").InvalidInputErrorCode;
const LimitExceededErrorCode = @import("limit_exceeded_error_code.zig").LimitExceededErrorCode;
const NoSuchEntityErrorCode = @import("no_such_entity_error_code.zig").NoSuchEntityErrorCode;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        agents_already_running_assessment_exception: AgentsAlreadyRunningAssessmentException,
        assessment_run_in_progress_exception: AssessmentRunInProgressException,
        internal_exception: InternalException,
        invalid_cross_account_role_exception: InvalidCrossAccountRoleException,
        invalid_input_exception: InvalidInputException,
        limit_exceeded_exception: LimitExceededException,
        no_such_entity_exception: NoSuchEntityException,
        preview_generation_in_progress_exception: PreviewGenerationInProgressException,
        service_temporarily_unavailable_exception: ServiceTemporarilyUnavailableException,
        unsupported_feature_exception: UnsupportedFeatureException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .agents_already_running_assessment_exception => "AgentsAlreadyRunningAssessmentException",
                .assessment_run_in_progress_exception => "AssessmentRunInProgressException",
                .internal_exception => "InternalException",
                .invalid_cross_account_role_exception => "InvalidCrossAccountRoleException",
                .invalid_input_exception => "InvalidInputException",
                .limit_exceeded_exception => "LimitExceededException",
                .no_such_entity_exception => "NoSuchEntityException",
                .preview_generation_in_progress_exception => "PreviewGenerationInProgressException",
                .service_temporarily_unavailable_exception => "ServiceTemporarilyUnavailableException",
                .unsupported_feature_exception => "UnsupportedFeatureException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .agents_already_running_assessment_exception => |e| e.message,
                .assessment_run_in_progress_exception => |e| e.message,
                .internal_exception => |e| e.message,
                .invalid_cross_account_role_exception => |e| e.message,
                .invalid_input_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .no_such_entity_exception => |e| e.message,
                .preview_generation_in_progress_exception => |e| e.message,
                .service_temporarily_unavailable_exception => |e| e.message,
                .unsupported_feature_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .agents_already_running_assessment_exception => 400,
                .assessment_run_in_progress_exception => 400,
                .internal_exception => 500,
                .invalid_cross_account_role_exception => 400,
                .invalid_input_exception => 400,
                .limit_exceeded_exception => 400,
                .no_such_entity_exception => 400,
                .preview_generation_in_progress_exception => 400,
                .service_temporarily_unavailable_exception => 503,
                .unsupported_feature_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .agents_already_running_assessment_exception => |e| e.request_id,
                .assessment_run_in_progress_exception => |e| e.request_id,
                .internal_exception => |e| e.request_id,
                .invalid_cross_account_role_exception => |e| e.request_id,
                .invalid_input_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .no_such_entity_exception => |e| e.request_id,
                .preview_generation_in_progress_exception => |e| e.request_id,
                .service_temporarily_unavailable_exception => |e| e.request_id,
                .unsupported_feature_exception => |e| e.request_id,
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

/// You do not have required permissions to access the requested resource.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// You can immediately retry your request.
    can_retry: bool,

    /// Code that indicates the type of error that is generated.
    error_code: ?AccessDeniedErrorCode = null,

    pub const json_field_names = .{
        .can_retry = "canRetry",
        .error_code = "errorCode",
        .message = "message",
    };
};

/// You started an assessment run, but one of the instances is already
/// participating in
/// another assessment run.
pub const AgentsAlreadyRunningAssessmentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    agents: ?[]const AgentAlreadyRunningAssessment = null,

    agents_truncated: bool,

    /// You can immediately retry your request.
    can_retry: bool,

    pub const json_field_names = .{
        .agents = "agents",
        .agents_truncated = "agentsTruncated",
        .can_retry = "canRetry",
        .message = "message",
    };
};

/// You cannot perform a specified action if an assessment run is currently in
/// progress.
pub const AssessmentRunInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The ARNs of the assessment runs that are currently in progress.
    assessment_run_arns: ?[]const []const u8 = null,

    /// Boolean value that indicates whether the ARN list of the assessment runs is
    /// truncated.
    assessment_run_arns_truncated: bool,

    /// You can immediately retry your request.
    can_retry: bool,

    pub const json_field_names = .{
        .assessment_run_arns = "assessmentRunArns",
        .assessment_run_arns_truncated = "assessmentRunArnsTruncated",
        .can_retry = "canRetry",
        .message = "message",
    };
};

/// Internal server error.
pub const InternalException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// You can immediately retry your request.
    can_retry: bool,

    pub const json_field_names = .{
        .can_retry = "canRetry",
        .message = "message",
    };
};

/// Amazon Inspector cannot assume the cross-account role that it needs to list
/// your EC2
/// instances during the assessment run.
pub const InvalidCrossAccountRoleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// You can immediately retry your request.
    can_retry: bool,

    /// Code that indicates the type of error that is generated.
    error_code: ?InvalidCrossAccountRoleErrorCode = null,

    pub const json_field_names = .{
        .can_retry = "canRetry",
        .error_code = "errorCode",
        .message = "message",
    };
};

/// The request was rejected because an invalid or out-of-range value was
/// supplied for an
/// input parameter.
pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// You can immediately retry your request.
    can_retry: bool,

    /// Code that indicates the type of error that is generated.
    error_code: ?InvalidInputErrorCode = null,

    pub const json_field_names = .{
        .can_retry = "canRetry",
        .error_code = "errorCode",
        .message = "message",
    };
};

/// The request was rejected because it attempted to create resources beyond the
/// current
/// AWS account limits. The error code describes the limit exceeded.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// You can immediately retry your request.
    can_retry: bool,

    /// Code that indicates the type of error that is generated.
    error_code: ?LimitExceededErrorCode = null,

    pub const json_field_names = .{
        .can_retry = "canRetry",
        .error_code = "errorCode",
        .message = "message",
    };
};

/// The request was rejected because it referenced an entity that does not
/// exist. The
/// error code describes the entity.
pub const NoSuchEntityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// You can immediately retry your request.
    can_retry: bool,

    /// Code that indicates the type of error that is generated.
    error_code: ?NoSuchEntityErrorCode = null,

    pub const json_field_names = .{
        .can_retry = "canRetry",
        .error_code = "errorCode",
        .message = "message",
    };
};

/// The request is rejected. The specified assessment template is currently
/// generating an
/// exclusions preview.
pub const PreviewGenerationInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The serice is temporary unavailable.
pub const ServiceTemporarilyUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// You can wait and then retry your request.
    can_retry: bool,

    pub const json_field_names = .{
        .can_retry = "canRetry",
        .message = "message",
    };
};

/// Used by the GetAssessmentReport API. The request was rejected
/// because you tried to generate a report for an assessment run that existed
/// before reporting
/// was supported in Amazon Inspector. You can only generate reports for
/// assessment runs that
/// took place or will take place after generating reports in Amazon Inspector
/// became
/// available.
pub const UnsupportedFeatureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    can_retry: bool,

    pub const json_field_names = .{
        .can_retry = "canRetry",
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
    if (std.mem.eql(u8, error_code, "AgentsAlreadyRunningAssessmentException")) {
        const parsed_error: ?AgentsAlreadyRunningAssessmentException = aws.json.parseJsonObject(AgentsAlreadyRunningAssessmentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .agents_already_running_assessment_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssessmentRunInProgressException")) {
        const parsed_error: ?AssessmentRunInProgressException = aws.json.parseJsonObject(AssessmentRunInProgressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .assessment_run_in_progress_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalException")) {
        const parsed_error: ?InternalException = aws.json.parseJsonObject(InternalException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidCrossAccountRoleException")) {
        const parsed_error: ?InvalidCrossAccountRoleException = aws.json.parseJsonObject(InvalidCrossAccountRoleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_cross_account_role_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        const parsed_error: ?InvalidInputException = aws.json.parseJsonObject(InvalidInputException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_input_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "NoSuchEntityException")) {
        const parsed_error: ?NoSuchEntityException = aws.json.parseJsonObject(NoSuchEntityException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_entity_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PreviewGenerationInProgressException")) {
        const parsed_error: ?PreviewGenerationInProgressException = aws.json.parseJsonObject(PreviewGenerationInProgressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .preview_generation_in_progress_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceTemporarilyUnavailableException")) {
        const parsed_error: ?ServiceTemporarilyUnavailableException = aws.json.parseJsonObject(ServiceTemporarilyUnavailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_temporarily_unavailable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedFeatureException")) {
        const parsed_error: ?UnsupportedFeatureException = aws.json.parseJsonObject(UnsupportedFeatureException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_feature_exception = typed_error } };
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
