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

/// You are not authorized to perform the action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// A User with the same Id already exists within the collection, or the update
/// or deletion
/// of the User caused an inconsistent state. **
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// The number of in-progress human reviews you have has exceeded the number
/// allowed.
pub const HumanLoopQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    /// The quota code.
    quota_code: ?[]const u8 = null,

    /// The resource type.
    resource_type: ?[]const u8 = null,

    /// The service code.
    service_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
        .quota_code = "QuotaCode",
        .resource_type = "ResourceType",
        .service_code = "ServiceCode",
    };
};

/// A `ClientRequestToken` input parameter was reused with an operation, but at
/// least one of the other input
/// parameters is different from the previous call to the operation.
pub const IdempotentParameterMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// The input image size exceeds the allowed limit. If you are calling
/// DetectProtectiveEquipment, the image size or resolution exceeds the allowed
/// limit. For more
/// information, see Guidelines and quotas in Amazon Rekognition in the Amazon
/// Rekognition Developer Guide.
pub const ImageTooLargeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// Amazon Rekognition experienced a service issue. Try your call again.
pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// The provided image format is not supported.
pub const InvalidImageFormatException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// Indicates that a provided manifest file is empty or larger than the allowed
/// limit.
pub const InvalidManifestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// Pagination token in the request is not valid.
pub const InvalidPaginationTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// Input parameter violated a constraint. Validate your parameter before
/// calling the API
/// operation again.
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// The supplied revision id for the project policy is invalid.
pub const InvalidPolicyRevisionIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// Amazon Rekognition is unable to access the S3 object specified in the
/// request.
pub const InvalidS3ObjectException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// An Amazon Rekognition service limit was exceeded. For example, if you start
/// too many jobs
/// concurrently, subsequent calls to start operations (ex:
/// `StartLabelDetection`) will raise a `LimitExceededException`
/// exception (HTTP status code: 400) until the number of concurrently running
/// jobs is below
/// the Amazon Rekognition service limit.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// The format of the project policy document that you supplied to
/// `PutProjectPolicy` is incorrect.
pub const MalformedPolicyDocumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// The number of requests exceeded your throughput limit. If you want to
/// increase this
/// limit, contact Amazon Rekognition.
pub const ProvisionedThroughputExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// A resource with the specified ID already exists.
pub const ResourceAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// The specified resource is already being used.
pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// The resource specified in the request cannot be found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// The requested resource isn't ready. For example,
/// this exception occurs when you call `DetectCustomLabels` with a
/// model version that isn't deployed.
pub const ResourceNotReadyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// The size of the collection exceeds the allowed limit. For more information,
/// see Guidelines and quotas in Amazon Rekognition in the Amazon Rekognition
/// Developer Guide.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// Occurs when a given sessionId is not found.
pub const SessionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// Amazon Rekognition is temporarily unable to process the request. Try your
/// call again.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

/// The file size or duration of the supplied media is too large. The maximum
/// file size is 10GB.
/// The maximum duration is 6 hours.
pub const VideoTooLargeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for the request.
    logref: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .logref = "Logref",
        .message = "Message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
