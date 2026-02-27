const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        idempotent_parameter_mismatch_exception: IdempotentParameterMismatchException,
        internal_server_exception: InternalServerException,
        invalid_input_exception: InvalidInputException,
        invalid_tag_exception: InvalidTagException,
        limit_exceeded_exception: LimitExceededException,
        predictor_not_mounted_exception: PredictorNotMountedException,
        resource_not_found_exception: ResourceNotFoundException,
        tag_limit_exceeded_exception: TagLimitExceededException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .idempotent_parameter_mismatch_exception => "IdempotentParameterMismatchException",
                .internal_server_exception => "InternalServerException",
                .invalid_input_exception => "InvalidInputException",
                .invalid_tag_exception => "InvalidTagException",
                .limit_exceeded_exception => "LimitExceededException",
                .predictor_not_mounted_exception => "PredictorNotMountedException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .tag_limit_exceeded_exception => "TagLimitExceededException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .idempotent_parameter_mismatch_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .invalid_input_exception => |e| e.message,
                .invalid_tag_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .predictor_not_mounted_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .tag_limit_exceeded_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .idempotent_parameter_mismatch_exception => 400,
                .internal_server_exception => 500,
                .invalid_input_exception => 400,
                .invalid_tag_exception => 400,
                .limit_exceeded_exception => 417,
                .predictor_not_mounted_exception => 400,
                .resource_not_found_exception => 404,
                .tag_limit_exceeded_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .idempotent_parameter_mismatch_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .invalid_input_exception => |e| e.request_id,
                .invalid_tag_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .predictor_not_mounted_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .tag_limit_exceeded_exception => |e| e.request_id,
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

pub const IdempotentParameterMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTagException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PredictorNotMountedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
