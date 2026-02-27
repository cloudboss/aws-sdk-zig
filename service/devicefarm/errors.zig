const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        argument_exception: ArgumentException,
        cannot_delete_exception: CannotDeleteException,
        idempotency_exception: IdempotencyException,
        internal_service_exception: InternalServiceException,
        invalid_operation_exception: InvalidOperationException,
        limit_exceeded_exception: LimitExceededException,
        not_eligible_exception: NotEligibleException,
        not_found_exception: NotFoundException,
        service_account_exception: ServiceAccountException,
        tag_operation_exception: TagOperationException,
        tag_policy_exception: TagPolicyException,
        too_many_tags_exception: TooManyTagsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .argument_exception => "ArgumentException",
                .cannot_delete_exception => "CannotDeleteException",
                .idempotency_exception => "IdempotencyException",
                .internal_service_exception => "InternalServiceException",
                .invalid_operation_exception => "InvalidOperationException",
                .limit_exceeded_exception => "LimitExceededException",
                .not_eligible_exception => "NotEligibleException",
                .not_found_exception => "NotFoundException",
                .service_account_exception => "ServiceAccountException",
                .tag_operation_exception => "TagOperationException",
                .tag_policy_exception => "TagPolicyException",
                .too_many_tags_exception => "TooManyTagsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .argument_exception => |e| e.message,
                .cannot_delete_exception => |e| e.message,
                .idempotency_exception => |e| e.message,
                .internal_service_exception => |e| e.message,
                .invalid_operation_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .not_eligible_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .service_account_exception => |e| e.message,
                .tag_operation_exception => |e| e.message,
                .tag_policy_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .argument_exception => 400,
                .cannot_delete_exception => 409,
                .idempotency_exception => 400,
                .internal_service_exception => 500,
                .invalid_operation_exception => 400,
                .limit_exceeded_exception => 400,
                .not_eligible_exception => 400,
                .not_found_exception => 400,
                .service_account_exception => 400,
                .tag_operation_exception => 400,
                .tag_policy_exception => 400,
                .too_many_tags_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .argument_exception => |e| e.request_id,
                .cannot_delete_exception => |e| e.request_id,
                .idempotency_exception => |e| e.request_id,
                .internal_service_exception => |e| e.request_id,
                .invalid_operation_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .not_eligible_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .service_account_exception => |e| e.request_id,
                .tag_operation_exception => |e| e.request_id,
                .tag_policy_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
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

pub const ArgumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CannotDeleteException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IdempotencyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotEligibleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceAccountException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
