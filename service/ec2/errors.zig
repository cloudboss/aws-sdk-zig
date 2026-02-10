const std = @import("std");

pub const ServiceError = union(enum) {
    unknown: UnknownServiceError,

    pub fn code(self: ServiceError) []const u8 {
        return switch (self) {
            .unknown => |e| e.code,
        };
    }

    pub fn message(self: ServiceError) []const u8 {
        return switch (self) {
            .unknown => |e| e.message,
        };
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return switch (self) {
            .unknown => |e| e.http_status,
        };
    }

    pub fn requestId(self: ServiceError) []const u8 {
        return switch (self) {
            .unknown => |e| e.request_id,
        };
    }
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
