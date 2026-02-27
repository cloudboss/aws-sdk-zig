const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        concurrent_modification_exception: ConcurrentModificationException,
        conflict_exception: ConflictException,
        dashboard_invalid_input_error: DashboardInvalidInputError,
        dashboard_not_found_error: DashboardNotFoundError,
        internal_service_fault: InternalServiceFault,
        invalid_format_fault: InvalidFormatFault,
        invalid_next_token: InvalidNextToken,
        invalid_parameter_combination_exception: InvalidParameterCombinationException,
        invalid_parameter_value_exception: InvalidParameterValueException,
        limit_exceeded_exception: LimitExceededException,
        limit_exceeded_fault: LimitExceededFault,
        missing_required_parameter_exception: MissingRequiredParameterException,
        resource_not_found: ResourceNotFound,
        resource_not_found_exception: ResourceNotFoundException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => "ConcurrentModificationException",
                .conflict_exception => "ConflictException",
                .dashboard_invalid_input_error => "DashboardInvalidInputError",
                .dashboard_not_found_error => "DashboardNotFoundError",
                .internal_service_fault => "InternalServiceFault",
                .invalid_format_fault => "InvalidFormatFault",
                .invalid_next_token => "InvalidNextToken",
                .invalid_parameter_combination_exception => "InvalidParameterCombinationException",
                .invalid_parameter_value_exception => "InvalidParameterValueException",
                .limit_exceeded_exception => "LimitExceededException",
                .limit_exceeded_fault => "LimitExceededFault",
                .missing_required_parameter_exception => "MissingRequiredParameterException",
                .resource_not_found => "ResourceNotFound",
                .resource_not_found_exception => "ResourceNotFoundException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .dashboard_invalid_input_error => |e| e.message,
                .dashboard_not_found_error => |e| e.message,
                .internal_service_fault => |e| e.message,
                .invalid_format_fault => |e| e.message,
                .invalid_next_token => |e| e.message,
                .invalid_parameter_combination_exception => |e| e.message,
                .invalid_parameter_value_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .limit_exceeded_fault => |e| e.message,
                .missing_required_parameter_exception => |e| e.message,
                .resource_not_found => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .concurrent_modification_exception => 429,
                .conflict_exception => 409,
                .dashboard_invalid_input_error => 400,
                .dashboard_not_found_error => 404,
                .internal_service_fault => 500,
                .invalid_format_fault => 400,
                .invalid_next_token => 400,
                .invalid_parameter_combination_exception => 400,
                .invalid_parameter_value_exception => 400,
                .limit_exceeded_exception => 400,
                .limit_exceeded_fault => 400,
                .missing_required_parameter_exception => 400,
                .resource_not_found => 404,
                .resource_not_found_exception => 404,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .dashboard_invalid_input_error => |e| e.request_id,
                .dashboard_not_found_error => |e| e.request_id,
                .internal_service_fault => |e| e.request_id,
                .invalid_format_fault => |e| e.request_id,
                .invalid_next_token => |e| e.request_id,
                .invalid_parameter_combination_exception => |e| e.request_id,
                .invalid_parameter_value_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .limit_exceeded_fault => |e| e.request_id,
                .missing_required_parameter_exception => |e| e.request_id,
                .resource_not_found => |e| e.request_id,
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

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DashboardInvalidInputError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DashboardNotFoundError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServiceFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidFormatFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNextToken = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterCombinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MissingRequiredParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFound = struct {
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
