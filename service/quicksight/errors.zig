const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        concurrent_updating_exception: ConcurrentUpdatingException,
        conflict_exception: ConflictException,
        customer_managed_key_unavailable_exception: CustomerManagedKeyUnavailableException,
        domain_not_whitelisted_exception: DomainNotWhitelistedException,
        identity_type_not_supported_exception: IdentityTypeNotSupportedException,
        internal_failure_exception: InternalFailureException,
        internal_server_exception: InternalServerException,
        invalid_data_set_parameter_value_exception: InvalidDataSetParameterValueException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_parameter_value_exception: InvalidParameterValueException,
        invalid_request_exception: InvalidRequestException,
        limit_exceeded_exception: LimitExceededException,
        precondition_not_met_exception: PreconditionNotMetException,
        quick_sight_user_not_found_exception: QuickSightUserNotFoundException,
        resource_exists_exception: ResourceExistsException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_unavailable_exception: ResourceUnavailableException,
        session_lifetime_in_minutes_invalid_exception: SessionLifetimeInMinutesInvalidException,
        throttling_exception: ThrottlingException,
        unsupported_pricing_plan_exception: UnsupportedPricingPlanException,
        unsupported_user_edition_exception: UnsupportedUserEditionException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .concurrent_updating_exception => "ConcurrentUpdatingException",
                .conflict_exception => "ConflictException",
                .customer_managed_key_unavailable_exception => "CustomerManagedKeyUnavailableException",
                .domain_not_whitelisted_exception => "DomainNotWhitelistedException",
                .identity_type_not_supported_exception => "IdentityTypeNotSupportedException",
                .internal_failure_exception => "InternalFailureException",
                .internal_server_exception => "InternalServerException",
                .invalid_data_set_parameter_value_exception => "InvalidDataSetParameterValueException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_parameter_value_exception => "InvalidParameterValueException",
                .invalid_request_exception => "InvalidRequestException",
                .limit_exceeded_exception => "LimitExceededException",
                .precondition_not_met_exception => "PreconditionNotMetException",
                .quick_sight_user_not_found_exception => "QuickSightUserNotFoundException",
                .resource_exists_exception => "ResourceExistsException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_unavailable_exception => "ResourceUnavailableException",
                .session_lifetime_in_minutes_invalid_exception => "SessionLifetimeInMinutesInvalidException",
                .throttling_exception => "ThrottlingException",
                .unsupported_pricing_plan_exception => "UnsupportedPricingPlanException",
                .unsupported_user_edition_exception => "UnsupportedUserEditionException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .concurrent_updating_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .customer_managed_key_unavailable_exception => |e| e.message,
                .domain_not_whitelisted_exception => |e| e.message,
                .identity_type_not_supported_exception => |e| e.message,
                .internal_failure_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .invalid_data_set_parameter_value_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_parameter_value_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .precondition_not_met_exception => |e| e.message,
                .quick_sight_user_not_found_exception => |e| e.message,
                .resource_exists_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_unavailable_exception => |e| e.message,
                .session_lifetime_in_minutes_invalid_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unsupported_pricing_plan_exception => |e| e.message,
                .unsupported_user_edition_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 401,
                .concurrent_updating_exception => 500,
                .conflict_exception => 409,
                .customer_managed_key_unavailable_exception => 400,
                .domain_not_whitelisted_exception => 403,
                .identity_type_not_supported_exception => 403,
                .internal_failure_exception => 500,
                .internal_server_exception => 500,
                .invalid_data_set_parameter_value_exception => 400,
                .invalid_next_token_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_parameter_value_exception => 400,
                .invalid_request_exception => 400,
                .limit_exceeded_exception => 409,
                .precondition_not_met_exception => 400,
                .quick_sight_user_not_found_exception => 404,
                .resource_exists_exception => 409,
                .resource_not_found_exception => 404,
                .resource_unavailable_exception => 503,
                .session_lifetime_in_minutes_invalid_exception => 400,
                .throttling_exception => 429,
                .unsupported_pricing_plan_exception => 403,
                .unsupported_user_edition_exception => 403,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .concurrent_updating_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .customer_managed_key_unavailable_exception => |e| e.request_id,
                .domain_not_whitelisted_exception => |e| e.request_id,
                .identity_type_not_supported_exception => |e| e.request_id,
                .internal_failure_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .invalid_data_set_parameter_value_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_parameter_value_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .precondition_not_met_exception => |e| e.request_id,
                .quick_sight_user_not_found_exception => |e| e.request_id,
                .resource_exists_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_unavailable_exception => |e| e.request_id,
                .session_lifetime_in_minutes_invalid_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .unsupported_pricing_plan_exception => |e| e.request_id,
                .unsupported_user_edition_exception => |e| e.request_id,
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

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentUpdatingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CustomerManagedKeyUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DomainNotWhitelistedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IdentityTypeNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDataSetParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PreconditionNotMetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const QuickSightUserNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SessionLifetimeInMinutesInvalidException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedPricingPlanException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedUserEditionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
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
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentUpdatingException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_updating_exception = .{
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
    if (std.mem.eql(u8, error_code, "CustomerManagedKeyUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .customer_managed_key_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DomainNotWhitelistedException")) {
        return .{ .arena = arena, .kind = .{ .domain_not_whitelisted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdentityTypeNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .identity_type_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDataSetParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_data_set_parameter_value_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "PreconditionNotMetException")) {
        return .{ .arena = arena, .kind = .{ .precondition_not_met_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QuickSightUserNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .quick_sight_user_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SessionLifetimeInMinutesInvalidException")) {
        return .{ .arena = arena, .kind = .{ .session_lifetime_in_minutes_invalid_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedPricingPlanException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_pricing_plan_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedUserEditionException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_user_edition_exception = .{
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
