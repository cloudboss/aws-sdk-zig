const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        concurrent_modification_exception: ConcurrentModificationException,
        illegal_status_exception: IllegalStatusException,
        internal_exception: InternalException,
        invalid_event_pattern_exception: InvalidEventPatternException,
        invalid_state_exception: InvalidStateException,
        limit_exceeded_exception: LimitExceededException,
        managed_rule_exception: ManagedRuleException,
        operation_disabled_exception: OperationDisabledException,
        policy_length_exceeded_exception: PolicyLengthExceededException,
        resource_already_exists_exception: ResourceAlreadyExistsException,
        resource_not_found_exception: ResourceNotFoundException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => "ConcurrentModificationException",
                .illegal_status_exception => "IllegalStatusException",
                .internal_exception => "InternalException",
                .invalid_event_pattern_exception => "InvalidEventPatternException",
                .invalid_state_exception => "InvalidStateException",
                .limit_exceeded_exception => "LimitExceededException",
                .managed_rule_exception => "ManagedRuleException",
                .operation_disabled_exception => "OperationDisabledException",
                .policy_length_exceeded_exception => "PolicyLengthExceededException",
                .resource_already_exists_exception => "ResourceAlreadyExistsException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.message,
                .illegal_status_exception => |e| e.message,
                .internal_exception => |e| e.message,
                .invalid_event_pattern_exception => |e| e.message,
                .invalid_state_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .managed_rule_exception => |e| e.message,
                .operation_disabled_exception => |e| e.message,
                .policy_length_exceeded_exception => |e| e.message,
                .resource_already_exists_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .concurrent_modification_exception => 400,
                .illegal_status_exception => 400,
                .internal_exception => 500,
                .invalid_event_pattern_exception => 400,
                .invalid_state_exception => 400,
                .limit_exceeded_exception => 400,
                .managed_rule_exception => 400,
                .operation_disabled_exception => 400,
                .policy_length_exceeded_exception => 400,
                .resource_already_exists_exception => 400,
                .resource_not_found_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.request_id,
                .illegal_status_exception => |e| e.request_id,
                .internal_exception => |e| e.request_id,
                .invalid_event_pattern_exception => |e| e.request_id,
                .invalid_state_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .managed_rule_exception => |e| e.request_id,
                .operation_disabled_exception => |e| e.request_id,
                .policy_length_exceeded_exception => |e| e.request_id,
                .resource_already_exists_exception => |e| e.request_id,
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

pub const IllegalStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidEventPatternException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ManagedRuleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyLengthExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceAlreadyExistsException = struct {
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
