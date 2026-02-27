const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        concurrent_modification_exception: ConcurrentModificationException,
        dry_run_operation_exception: DryRunOperationException,
        entitlement_already_exists_exception: EntitlementAlreadyExistsException,
        entitlement_not_found_exception: EntitlementNotFoundException,
        incompatible_image_exception: IncompatibleImageException,
        invalid_account_status_exception: InvalidAccountStatusException,
        invalid_parameter_combination_exception: InvalidParameterCombinationException,
        invalid_role_exception: InvalidRoleException,
        limit_exceeded_exception: LimitExceededException,
        operation_not_permitted_exception: OperationNotPermittedException,
        request_limit_exceeded_exception: RequestLimitExceededException,
        resource_already_exists_exception: ResourceAlreadyExistsException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_available_exception: ResourceNotAvailableException,
        resource_not_found_exception: ResourceNotFoundException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => "ConcurrentModificationException",
                .dry_run_operation_exception => "DryRunOperationException",
                .entitlement_already_exists_exception => "EntitlementAlreadyExistsException",
                .entitlement_not_found_exception => "EntitlementNotFoundException",
                .incompatible_image_exception => "IncompatibleImageException",
                .invalid_account_status_exception => "InvalidAccountStatusException",
                .invalid_parameter_combination_exception => "InvalidParameterCombinationException",
                .invalid_role_exception => "InvalidRoleException",
                .limit_exceeded_exception => "LimitExceededException",
                .operation_not_permitted_exception => "OperationNotPermittedException",
                .request_limit_exceeded_exception => "RequestLimitExceededException",
                .resource_already_exists_exception => "ResourceAlreadyExistsException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_available_exception => "ResourceNotAvailableException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.message,
                .dry_run_operation_exception => |e| e.message,
                .entitlement_already_exists_exception => |e| e.message,
                .entitlement_not_found_exception => |e| e.message,
                .incompatible_image_exception => |e| e.message,
                .invalid_account_status_exception => |e| e.message,
                .invalid_parameter_combination_exception => |e| e.message,
                .invalid_role_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .operation_not_permitted_exception => |e| e.message,
                .request_limit_exceeded_exception => |e| e.message,
                .resource_already_exists_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_available_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .concurrent_modification_exception => 400,
                .dry_run_operation_exception => 412,
                .entitlement_already_exists_exception => 400,
                .entitlement_not_found_exception => 400,
                .incompatible_image_exception => 400,
                .invalid_account_status_exception => 400,
                .invalid_parameter_combination_exception => 400,
                .invalid_role_exception => 400,
                .limit_exceeded_exception => 400,
                .operation_not_permitted_exception => 400,
                .request_limit_exceeded_exception => 400,
                .resource_already_exists_exception => 400,
                .resource_in_use_exception => 400,
                .resource_not_available_exception => 400,
                .resource_not_found_exception => 404,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.request_id,
                .dry_run_operation_exception => |e| e.request_id,
                .entitlement_already_exists_exception => |e| e.request_id,
                .entitlement_not_found_exception => |e| e.request_id,
                .incompatible_image_exception => |e| e.request_id,
                .invalid_account_status_exception => |e| e.request_id,
                .invalid_parameter_combination_exception => |e| e.request_id,
                .invalid_role_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .operation_not_permitted_exception => |e| e.request_id,
                .request_limit_exceeded_exception => |e| e.request_id,
                .resource_already_exists_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_available_exception => |e| e.request_id,
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

pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DryRunOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EntitlementAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EntitlementNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IncompatibleImageException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAccountStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterCombinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRoleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationNotPermittedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RequestLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotAvailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
