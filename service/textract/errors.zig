const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        bad_document_exception: BadDocumentException,
        conflict_exception: ConflictException,
        document_too_large_exception: DocumentTooLargeException,
        human_loop_quota_exceeded_exception: HumanLoopQuotaExceededException,
        idempotent_parameter_mismatch_exception: IdempotentParameterMismatchException,
        internal_server_error: InternalServerError,
        invalid_job_id_exception: InvalidJobIdException,
        invalid_kms_key_exception: InvalidKMSKeyException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_s3_object_exception: InvalidS3ObjectException,
        limit_exceeded_exception: LimitExceededException,
        provisioned_throughput_exceeded_exception: ProvisionedThroughputExceededException,
        resource_not_found_exception: ResourceNotFoundException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        throttling_exception: ThrottlingException,
        unsupported_document_exception: UnsupportedDocumentException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .bad_document_exception => "BadDocumentException",
                .conflict_exception => "ConflictException",
                .document_too_large_exception => "DocumentTooLargeException",
                .human_loop_quota_exceeded_exception => "HumanLoopQuotaExceededException",
                .idempotent_parameter_mismatch_exception => "IdempotentParameterMismatchException",
                .internal_server_error => "InternalServerError",
                .invalid_job_id_exception => "InvalidJobIdException",
                .invalid_kms_key_exception => "InvalidKMSKeyException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_s3_object_exception => "InvalidS3ObjectException",
                .limit_exceeded_exception => "LimitExceededException",
                .provisioned_throughput_exceeded_exception => "ProvisionedThroughputExceededException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .throttling_exception => "ThrottlingException",
                .unsupported_document_exception => "UnsupportedDocumentException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .bad_document_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .document_too_large_exception => |e| e.message,
                .human_loop_quota_exceeded_exception => |e| e.message,
                .idempotent_parameter_mismatch_exception => |e| e.message,
                .internal_server_error => |e| e.message,
                .invalid_job_id_exception => |e| e.message,
                .invalid_kms_key_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_s3_object_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .provisioned_throughput_exceeded_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unsupported_document_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 400,
                .bad_document_exception => 400,
                .conflict_exception => 400,
                .document_too_large_exception => 400,
                .human_loop_quota_exceeded_exception => 402,
                .idempotent_parameter_mismatch_exception => 400,
                .internal_server_error => 500,
                .invalid_job_id_exception => 400,
                .invalid_kms_key_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_s3_object_exception => 400,
                .limit_exceeded_exception => 400,
                .provisioned_throughput_exceeded_exception => 400,
                .resource_not_found_exception => 400,
                .service_quota_exceeded_exception => 400,
                .throttling_exception => 500,
                .unsupported_document_exception => 400,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .bad_document_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .document_too_large_exception => |e| e.request_id,
                .human_loop_quota_exceeded_exception => |e| e.request_id,
                .idempotent_parameter_mismatch_exception => |e| e.request_id,
                .internal_server_error => |e| e.request_id,
                .invalid_job_id_exception => |e| e.request_id,
                .invalid_kms_key_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_s3_object_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .provisioned_throughput_exceeded_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .unsupported_document_exception => |e| e.request_id,
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

/// You aren't authorized to perform the action. Use the Amazon Resource Name
/// (ARN)
/// of an authorized user or IAM role to perform the operation.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};

/// Amazon Textract isn't able to read the document. For more information on the
/// document
/// limits in Amazon Textract, see limits.
pub const BadDocumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};

/// Updating or deleting a resource can cause an inconsistent state.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};

/// The document can't be processed because it's too large. The maximum document
/// size for
/// synchronous operations 10 MB. The maximum document size for asynchronous
/// operations is 500
/// MB for PDF files.
pub const DocumentTooLargeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};

/// Indicates you have exceeded the maximum number of active human in the loop
/// workflows available
pub const HumanLoopQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    /// The quota code.
    quota_code: ?[]const u8 = null,

    /// The resource type.
    resource_type: ?[]const u8 = null,

    /// The service code.
    service_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
        .quota_code = "QuotaCode",
        .resource_type = "ResourceType",
        .service_code = "ServiceCode",
    };
};

/// A `ClientRequestToken` input parameter was reused with an operation, but at
/// least one of the other input parameters is different from the previous call
/// to the
/// operation.
pub const IdempotentParameterMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};

/// Amazon Textract experienced a service issue. Try your call again.
pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};

/// An invalid job identifier was passed to an asynchronous analysis operation.
pub const InvalidJobIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};

/// Indicates you do not have decrypt permissions with the KMS key entered, or
/// the KMS key
/// was entered incorrectly.
pub const InvalidKMSKeyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};

/// An input parameter violated a constraint. For example, in synchronous
/// operations,
/// an `InvalidParameterException` exception occurs
/// when neither of the `S3Object` or `Bytes` values are supplied in the
/// `Document`
/// request parameter.
/// Validate your parameter before calling the API operation again.
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};

/// Amazon Textract is unable to access the S3 object that's specified in the
/// request.
/// for more information, [Configure Access to Amazon
/// S3](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html)
/// For troubleshooting information, see [Troubleshooting Amazon
/// S3](https://docs.aws.amazon.com/AmazonS3/latest/dev/troubleshooting.html)
pub const InvalidS3ObjectException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};

/// An Amazon Textract service limit was exceeded. For example, if you start too
/// many
/// asynchronous jobs concurrently, calls to start operations
/// (`StartDocumentTextDetection`, for example) raise a LimitExceededException
/// exception (HTTP status code: 400) until the number of concurrently running
/// jobs is below
/// the Amazon Textract service limit.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};

/// The number of requests exceeded your throughput limit. If you want to
/// increase this limit,
/// contact Amazon Textract.
pub const ProvisionedThroughputExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};

/// Returned when an operation tried to access a nonexistent resource.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};

/// Returned when a request cannot be completed as it would exceed a maximum
/// service quota.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};

/// Amazon Textract is temporarily unable to process the request. Try your call
/// again.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};

/// The format of the input document isn't supported. Documents for operations
/// can be in
/// PNG, JPEG, PDF, or TIFF format.
pub const UnsupportedDocumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};

/// Indicates that a request was not valid. Check request for proper formatting.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
