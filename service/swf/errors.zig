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

pub const DefaultUndefinedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DomainAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DomainDeprecatedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationNotPermittedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TypeAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TypeDeprecatedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TypeNotDeprecatedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownResourceFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WorkflowExecutionAlreadyStartedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
