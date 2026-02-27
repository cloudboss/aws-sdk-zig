const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        conflict_exception: ConflictException,
        human_loop_quota_exceeded_exception: HumanLoopQuotaExceededException,
        idempotent_parameter_mismatch_exception: IdempotentParameterMismatchException,
        image_too_large_exception: ImageTooLargeException,
        internal_server_error: InternalServerError,
        invalid_image_format_exception: InvalidImageFormatException,
        invalid_manifest_exception: InvalidManifestException,
        invalid_pagination_token_exception: InvalidPaginationTokenException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_policy_revision_id_exception: InvalidPolicyRevisionIdException,
        invalid_s3_object_exception: InvalidS3ObjectException,
        limit_exceeded_exception: LimitExceededException,
        malformed_policy_document_exception: MalformedPolicyDocumentException,
        provisioned_throughput_exceeded_exception: ProvisionedThroughputExceededException,
        resource_already_exists_exception: ResourceAlreadyExistsException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_not_ready_exception: ResourceNotReadyException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        session_not_found_exception: SessionNotFoundException,
        throttling_exception: ThrottlingException,
        video_too_large_exception: VideoTooLargeException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .conflict_exception => "ConflictException",
                .human_loop_quota_exceeded_exception => "HumanLoopQuotaExceededException",
                .idempotent_parameter_mismatch_exception => "IdempotentParameterMismatchException",
                .image_too_large_exception => "ImageTooLargeException",
                .internal_server_error => "InternalServerError",
                .invalid_image_format_exception => "InvalidImageFormatException",
                .invalid_manifest_exception => "InvalidManifestException",
                .invalid_pagination_token_exception => "InvalidPaginationTokenException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_policy_revision_id_exception => "InvalidPolicyRevisionIdException",
                .invalid_s3_object_exception => "InvalidS3ObjectException",
                .limit_exceeded_exception => "LimitExceededException",
                .malformed_policy_document_exception => "MalformedPolicyDocumentException",
                .provisioned_throughput_exceeded_exception => "ProvisionedThroughputExceededException",
                .resource_already_exists_exception => "ResourceAlreadyExistsException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_not_ready_exception => "ResourceNotReadyException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .session_not_found_exception => "SessionNotFoundException",
                .throttling_exception => "ThrottlingException",
                .video_too_large_exception => "VideoTooLargeException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .human_loop_quota_exceeded_exception => |e| e.message,
                .idempotent_parameter_mismatch_exception => |e| e.message,
                .image_too_large_exception => |e| e.message,
                .internal_server_error => |e| e.message,
                .invalid_image_format_exception => |e| e.message,
                .invalid_manifest_exception => |e| e.message,
                .invalid_pagination_token_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_policy_revision_id_exception => |e| e.message,
                .invalid_s3_object_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .malformed_policy_document_exception => |e| e.message,
                .provisioned_throughput_exceeded_exception => |e| e.message,
                .resource_already_exists_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_not_ready_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .session_not_found_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .video_too_large_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 400,
                .conflict_exception => 400,
                .human_loop_quota_exceeded_exception => 402,
                .idempotent_parameter_mismatch_exception => 400,
                .image_too_large_exception => 400,
                .internal_server_error => 500,
                .invalid_image_format_exception => 400,
                .invalid_manifest_exception => 400,
                .invalid_pagination_token_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_policy_revision_id_exception => 400,
                .invalid_s3_object_exception => 400,
                .limit_exceeded_exception => 400,
                .malformed_policy_document_exception => 400,
                .provisioned_throughput_exceeded_exception => 400,
                .resource_already_exists_exception => 400,
                .resource_in_use_exception => 400,
                .resource_not_found_exception => 400,
                .resource_not_ready_exception => 400,
                .service_quota_exceeded_exception => 400,
                .session_not_found_exception => 400,
                .throttling_exception => 500,
                .video_too_large_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .human_loop_quota_exceeded_exception => |e| e.request_id,
                .idempotent_parameter_mismatch_exception => |e| e.request_id,
                .image_too_large_exception => |e| e.request_id,
                .internal_server_error => |e| e.request_id,
                .invalid_image_format_exception => |e| e.request_id,
                .invalid_manifest_exception => |e| e.request_id,
                .invalid_pagination_token_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_policy_revision_id_exception => |e| e.request_id,
                .invalid_s3_object_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .malformed_policy_document_exception => |e| e.request_id,
                .provisioned_throughput_exceeded_exception => |e| e.request_id,
                .resource_already_exists_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_not_ready_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .session_not_found_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .video_too_large_exception => |e| e.request_id,
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

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HumanLoopQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IdempotentParameterMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ImageTooLargeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidImageFormatException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidManifestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPaginationTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPolicyRevisionIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidS3ObjectException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MalformedPolicyDocumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ProvisionedThroughputExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceAlreadyExistsException = struct {
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

pub const ResourceNotReadyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SessionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const VideoTooLargeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
