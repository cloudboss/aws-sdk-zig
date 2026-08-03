const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        concurrent_modification_exception: ConcurrentModificationException,
        invalid_argument_exception: InvalidArgumentException,
        invalid_kms_resource_exception: InvalidKMSResourceException,
        invalid_source_exception: InvalidSourceException,
        limit_exceeded_exception: LimitExceededException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_found_exception: ResourceNotFoundException,
        service_unavailable_exception: ServiceUnavailableException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => "ConcurrentModificationException",
                .invalid_argument_exception => "InvalidArgumentException",
                .invalid_kms_resource_exception => "InvalidKMSResourceException",
                .invalid_source_exception => "InvalidSourceException",
                .limit_exceeded_exception => "LimitExceededException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.message,
                .invalid_argument_exception => |e| e.message,
                .invalid_kms_resource_exception => |e| e.message,
                .invalid_source_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .concurrent_modification_exception => 400,
                .invalid_argument_exception => 400,
                .invalid_kms_resource_exception => 400,
                .invalid_source_exception => 400,
                .limit_exceeded_exception => 400,
                .resource_in_use_exception => 400,
                .resource_not_found_exception => 400,
                .service_unavailable_exception => 503,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.request_id,
                .invalid_argument_exception => |e| e.request_id,
                .invalid_kms_resource_exception => |e| e.request_id,
                .invalid_source_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
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

/// Another modification has already happened. Fetch `VersionId` again and use
/// it to update the destination.
pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified input parameter has a value that is not valid.
pub const InvalidArgumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Firehose throws this exception when an attempt to put records or to start
/// or stop Firehose stream encryption fails. This happens when the KMS service
/// throws one of
/// the following exception types: `AccessDeniedException`,
/// `InvalidStateException`, `DisabledException`, or
/// `NotFoundException`.
pub const InvalidKMSResourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};

/// Only requests from CloudWatch Logs are supported when CloudWatch Logs
/// decompression is enabled.
pub const InvalidSourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};

/// You have already reached the limit for a requested resource.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The resource is already in use and not available for this operation.
pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified resource could not be found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The service is unavailable. Back off and retry the operation. If you
/// continue to see
/// the exception, throughput limits for the Firehose stream may have been
/// exceeded. For more
/// information about limits and how to request an increase, see [Amazon
/// Firehose
/// Limits](https://docs.aws.amazon.com/firehose/latest/dev/limits.html).
pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
