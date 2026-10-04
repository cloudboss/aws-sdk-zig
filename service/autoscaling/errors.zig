const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        active_instance_refresh_not_found_fault: ActiveInstanceRefreshNotFoundFault,
        already_exists_fault: AlreadyExistsFault,
        idempotent_call_in_progress_fault: IdempotentCallInProgressFault,
        idempotent_parameter_mismatch_error: IdempotentParameterMismatchError,
        instance_refresh_in_progress_fault: InstanceRefreshInProgressFault,
        invalid_next_token: InvalidNextToken,
        irreversible_instance_refresh_fault: IrreversibleInstanceRefreshFault,
        limit_exceeded_fault: LimitExceededFault,
        resource_contention_fault: ResourceContentionFault,
        resource_in_use_fault: ResourceInUseFault,
        scaling_activity_in_progress_fault: ScalingActivityInProgressFault,
        service_linked_role_failure: ServiceLinkedRoleFailure,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .active_instance_refresh_not_found_fault => "ActiveInstanceRefreshNotFoundFault",
                .already_exists_fault => "AlreadyExistsFault",
                .idempotent_call_in_progress_fault => "IdempotentCallInProgressFault",
                .idempotent_parameter_mismatch_error => "IdempotentParameterMismatchError",
                .instance_refresh_in_progress_fault => "InstanceRefreshInProgressFault",
                .invalid_next_token => "InvalidNextToken",
                .irreversible_instance_refresh_fault => "IrreversibleInstanceRefreshFault",
                .limit_exceeded_fault => "LimitExceededFault",
                .resource_contention_fault => "ResourceContentionFault",
                .resource_in_use_fault => "ResourceInUseFault",
                .scaling_activity_in_progress_fault => "ScalingActivityInProgressFault",
                .service_linked_role_failure => "ServiceLinkedRoleFailure",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .active_instance_refresh_not_found_fault => |e| e.message,
                .already_exists_fault => |e| e.message,
                .idempotent_call_in_progress_fault => |e| e.message,
                .idempotent_parameter_mismatch_error => |e| e.message,
                .instance_refresh_in_progress_fault => |e| e.message,
                .invalid_next_token => |e| e.message,
                .irreversible_instance_refresh_fault => |e| e.message,
                .limit_exceeded_fault => |e| e.message,
                .resource_contention_fault => |e| e.message,
                .resource_in_use_fault => |e| e.message,
                .scaling_activity_in_progress_fault => |e| e.message,
                .service_linked_role_failure => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .active_instance_refresh_not_found_fault => 400,
                .already_exists_fault => 400,
                .idempotent_call_in_progress_fault => 500,
                .idempotent_parameter_mismatch_error => 400,
                .instance_refresh_in_progress_fault => 400,
                .invalid_next_token => 400,
                .irreversible_instance_refresh_fault => 400,
                .limit_exceeded_fault => 400,
                .resource_contention_fault => 500,
                .resource_in_use_fault => 400,
                .scaling_activity_in_progress_fault => 400,
                .service_linked_role_failure => 500,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .active_instance_refresh_not_found_fault => |e| e.request_id,
                .already_exists_fault => |e| e.request_id,
                .idempotent_call_in_progress_fault => |e| e.request_id,
                .idempotent_parameter_mismatch_error => |e| e.request_id,
                .instance_refresh_in_progress_fault => |e| e.request_id,
                .invalid_next_token => |e| e.request_id,
                .irreversible_instance_refresh_fault => |e| e.request_id,
                .limit_exceeded_fault => |e| e.request_id,
                .resource_contention_fault => |e| e.request_id,
                .resource_in_use_fault => |e| e.request_id,
                .scaling_activity_in_progress_fault => |e| e.request_id,
                .service_linked_role_failure => |e| e.request_id,
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

pub const ActiveInstanceRefreshNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IdempotentCallInProgressFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IdempotentParameterMismatchError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InstanceRefreshInProgressFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNextToken = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IrreversibleInstanceRefreshFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceContentionFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceInUseFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ScalingActivityInProgressFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceLinkedRoleFailure = struct {
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
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "ActiveInstanceRefreshNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .active_instance_refresh_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentCallInProgressFault")) {
        return .{ .arena = arena, .kind = .{ .idempotent_call_in_progress_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchError")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InstanceRefreshInProgressFault")) {
        return .{ .arena = arena, .kind = .{ .instance_refresh_in_progress_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextToken")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IrreversibleInstanceRefreshFault")) {
        return .{ .arena = arena, .kind = .{ .irreversible_instance_refresh_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceContentionFault")) {
        return .{ .arena = arena, .kind = .{ .resource_contention_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseFault")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScalingActivityInProgressFault")) {
        return .{ .arena = arena, .kind = .{ .scaling_activity_in_progress_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceLinkedRoleFailure")) {
        return .{ .arena = arena, .kind = .{ .service_linked_role_failure = .{
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
