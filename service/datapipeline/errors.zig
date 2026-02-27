const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        internal_service_error: InternalServiceError,
        invalid_request_exception: InvalidRequestException,
        pipeline_deleted_exception: PipelineDeletedException,
        pipeline_not_found_exception: PipelineNotFoundException,
        task_not_found_exception: TaskNotFoundException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .internal_service_error => "InternalServiceError",
                .invalid_request_exception => "InvalidRequestException",
                .pipeline_deleted_exception => "PipelineDeletedException",
                .pipeline_not_found_exception => "PipelineNotFoundException",
                .task_not_found_exception => "TaskNotFoundException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .internal_service_error => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .pipeline_deleted_exception => |e| e.message,
                .pipeline_not_found_exception => |e| e.message,
                .task_not_found_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .internal_service_error => 500,
                .invalid_request_exception => 400,
                .pipeline_deleted_exception => 400,
                .pipeline_not_found_exception => 400,
                .task_not_found_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .internal_service_error => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .pipeline_deleted_exception => |e| e.request_id,
                .pipeline_not_found_exception => |e| e.request_id,
                .task_not_found_exception => |e| e.request_id,
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

pub const InternalServiceError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PipelineDeletedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PipelineNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TaskNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
