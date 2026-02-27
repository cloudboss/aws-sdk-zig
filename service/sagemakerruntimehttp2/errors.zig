const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        input_validation_error: InputValidationError,
        internal_server_error: InternalServerError,
        internal_stream_failure: InternalStreamFailure,
        model_error: ModelError,
        model_stream_error: ModelStreamError,
        service_unavailable_error: ServiceUnavailableError,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .input_validation_error => "InputValidationError",
                .internal_server_error => "InternalServerError",
                .internal_stream_failure => "InternalStreamFailure",
                .model_error => "ModelError",
                .model_stream_error => "ModelStreamError",
                .service_unavailable_error => "ServiceUnavailableError",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .input_validation_error => |e| e.message,
                .internal_server_error => |e| e.message,
                .internal_stream_failure => |e| e.message,
                .model_error => |e| e.message,
                .model_stream_error => |e| e.message,
                .service_unavailable_error => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .input_validation_error => 400,
                .internal_server_error => 500,
                .internal_stream_failure => 500,
                .model_error => 424,
                .model_stream_error => 400,
                .service_unavailable_error => 503,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .input_validation_error => |e| e.request_id,
                .internal_server_error => |e| e.request_id,
                .internal_stream_failure => |e| e.request_id,
                .model_error => |e| e.request_id,
                .model_stream_error => |e| e.request_id,
                .service_unavailable_error => |e| e.request_id,
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

pub const InputValidationError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalStreamFailure = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ModelError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ModelStreamError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceUnavailableError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
