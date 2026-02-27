const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        custom_health_not_found: CustomHealthNotFound,
        duplicate_request: DuplicateRequest,
        instance_not_found: InstanceNotFound,
        invalid_input: InvalidInput,
        namespace_already_exists: NamespaceAlreadyExists,
        namespace_not_found: NamespaceNotFound,
        operation_not_found: OperationNotFound,
        request_limit_exceeded: RequestLimitExceeded,
        resource_in_use: ResourceInUse,
        resource_limit_exceeded: ResourceLimitExceeded,
        resource_not_found_exception: ResourceNotFoundException,
        service_already_exists: ServiceAlreadyExists,
        service_attributes_limit_exceeded_exception: ServiceAttributesLimitExceededException,
        service_not_found: ServiceNotFound,
        too_many_tags_exception: TooManyTagsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .custom_health_not_found => "CustomHealthNotFound",
                .duplicate_request => "DuplicateRequest",
                .instance_not_found => "InstanceNotFound",
                .invalid_input => "InvalidInput",
                .namespace_already_exists => "NamespaceAlreadyExists",
                .namespace_not_found => "NamespaceNotFound",
                .operation_not_found => "OperationNotFound",
                .request_limit_exceeded => "RequestLimitExceeded",
                .resource_in_use => "ResourceInUse",
                .resource_limit_exceeded => "ResourceLimitExceeded",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_already_exists => "ServiceAlreadyExists",
                .service_attributes_limit_exceeded_exception => "ServiceAttributesLimitExceededException",
                .service_not_found => "ServiceNotFound",
                .too_many_tags_exception => "TooManyTagsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .custom_health_not_found => |e| e.message,
                .duplicate_request => |e| e.message,
                .instance_not_found => |e| e.message,
                .invalid_input => |e| e.message,
                .namespace_already_exists => |e| e.message,
                .namespace_not_found => |e| e.message,
                .operation_not_found => |e| e.message,
                .request_limit_exceeded => |e| e.message,
                .resource_in_use => |e| e.message,
                .resource_limit_exceeded => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_already_exists => |e| e.message,
                .service_attributes_limit_exceeded_exception => |e| e.message,
                .service_not_found => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .custom_health_not_found => 404,
                .duplicate_request => 409,
                .instance_not_found => 404,
                .invalid_input => 400,
                .namespace_already_exists => 400,
                .namespace_not_found => 404,
                .operation_not_found => 404,
                .request_limit_exceeded => 429,
                .resource_in_use => 409,
                .resource_limit_exceeded => 400,
                .resource_not_found_exception => 404,
                .service_already_exists => 400,
                .service_attributes_limit_exceeded_exception => 400,
                .service_not_found => 404,
                .too_many_tags_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .custom_health_not_found => |e| e.request_id,
                .duplicate_request => |e| e.request_id,
                .instance_not_found => |e| e.request_id,
                .invalid_input => |e| e.request_id,
                .namespace_already_exists => |e| e.request_id,
                .namespace_not_found => |e| e.request_id,
                .operation_not_found => |e| e.request_id,
                .request_limit_exceeded => |e| e.request_id,
                .resource_in_use => |e| e.request_id,
                .resource_limit_exceeded => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_already_exists => |e| e.request_id,
                .service_attributes_limit_exceeded_exception => |e| e.request_id,
                .service_not_found => |e| e.request_id,
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

pub const CustomHealthNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateRequest = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InstanceNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInput = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NamespaceAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NamespaceNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RequestLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceAttributesLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceNotFound = struct {
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
