const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        active_instance_refresh_not_found_fault: ActiveInstanceRefreshNotFoundFault,
        already_exists_fault: AlreadyExistsFault,
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
