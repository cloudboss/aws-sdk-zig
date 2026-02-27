const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        duplicate_resource_exception: DuplicateResourceException,
        invalid_parameters_exception: InvalidParametersException,
        invalid_state_exception: InvalidStateException,
        limit_exceeded_exception: LimitExceededException,
        operation_not_supported_exception: OperationNotSupportedException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_found_exception: ResourceNotFoundException,
        tag_option_not_migrated_exception: TagOptionNotMigratedException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .duplicate_resource_exception => "DuplicateResourceException",
                .invalid_parameters_exception => "InvalidParametersException",
                .invalid_state_exception => "InvalidStateException",
                .limit_exceeded_exception => "LimitExceededException",
                .operation_not_supported_exception => "OperationNotSupportedException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .tag_option_not_migrated_exception => "TagOptionNotMigratedException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .duplicate_resource_exception => |e| e.message,
                .invalid_parameters_exception => |e| e.message,
                .invalid_state_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .operation_not_supported_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .tag_option_not_migrated_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .duplicate_resource_exception => 400,
                .invalid_parameters_exception => 400,
                .invalid_state_exception => 400,
                .limit_exceeded_exception => 400,
                .operation_not_supported_exception => 400,
                .resource_in_use_exception => 400,
                .resource_not_found_exception => 400,
                .tag_option_not_migrated_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .duplicate_resource_exception => |e| e.request_id,
                .invalid_parameters_exception => |e| e.request_id,
                .invalid_state_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .operation_not_supported_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .tag_option_not_migrated_exception => |e| e.request_id,
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

pub const DuplicateResourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParametersException = struct {
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

pub const OperationNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagOptionNotMigratedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
