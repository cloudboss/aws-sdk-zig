const std = @import("std");

const ConflictType = @import("conflict_type.zig").ConflictType;
const ResourceType = @import("resource_type.zig").ResourceType;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        conflict_exception: ConflictException,
        internal_server_exception: InternalServerException,
        resource_not_found_exception: ResourceNotFoundException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        throttling_exception: ThrottlingException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .conflict_exception => "ConflictException",
                .internal_server_exception => "InternalServerException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .throttling_exception => "ThrottlingException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .conflict_exception => 409,
                .internal_server_exception => 500,
                .resource_not_found_exception => 404,
                .service_quota_exceeded_exception => 402,
                .throttling_exception => 429,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .validation_exception => |e| e.request_id,
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

/// You do not have sufficient permissions to perform this action. Check the
/// error message
/// and try again.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request failed due to a conflict. Check the `ConflictType` and error
/// message for more details.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The type of conflict which caused a ConflictException. Possible types and
    /// the
    /// corresponding error messages are as follows:
    ///
    /// * `DOMAIN_NOT_ACTIVE`: The domain is not active.
    ///
    /// * `CANNOT_CHANGE_SPEAKER_AFTER_ENROLLMENT`: You cannot change the
    /// speaker ID after an enrollment has been requested.
    ///
    /// * `ENROLLMENT_ALREADY_EXISTS`: There is already an enrollment for
    /// this session.
    ///
    /// * `SPEAKER_NOT_SET`: You must set the speaker ID before requesting an
    /// enrollment.
    ///
    /// * `SPEAKER_OPTED_OUT`: You cannot request an enrollment for an opted
    /// out speaker.
    ///
    /// * `CONCURRENT_CHANGES`: The request could not be processed as the
    /// resource was modified by another request during execution.
    conflict_type: ?ConflictType = null,

    pub const json_field_names = .{
        .conflict_type = "ConflictType",
        .message = "Message",
    };
};

/// The request failed due to an unknown error on the server side.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified resource cannot be found. Check the `ResourceType` and error
/// message for more details.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The type of resource which cannot not be found. Possible types are
    /// `BATCH_JOB`, `COMPLIANCE_CONSENT`, `DOMAIN`,
    /// `FRAUDSTER`, `SESSION` and `SPEAKER`.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .message = "Message",
        .resource_type = "ResourceType",
    };
};

/// The request exceeded the service quota. Refer to [Voice ID Service
/// Quotas](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-service-limits.html#voiceid-quotas) and try your request again.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was denied due to request throttling. Please slow down your
/// request rate.
/// Refer to [
/// Amazon Connect Voice ID Service API throttling quotas
/// ](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-service-limits.html##voiceid-api-quotas) and try your
/// request again.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request failed one or more validations; check the error message for more
/// details.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
