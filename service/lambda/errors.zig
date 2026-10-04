const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        alias_limit_exceeded_exception: AliasLimitExceededException,
        callback_timeout_exception: CallbackTimeoutException,
        capacity_provider_limit_exceeded_exception: CapacityProviderLimitExceededException,
        code_artifact_user_deleted_exception: CodeArtifactUserDeletedException,
        code_artifact_user_failed_exception: CodeArtifactUserFailedException,
        code_artifact_user_pending_exception: CodeArtifactUserPendingException,
        code_signing_config_not_found_exception: CodeSigningConfigNotFoundException,
        code_storage_exceeded_exception: CodeStorageExceededException,
        code_verification_failed_exception: CodeVerificationFailedException,
        durable_execution_already_started_exception: DurableExecutionAlreadyStartedException,
        ec2_access_denied_exception: EC2AccessDeniedException,
        ec2_throttled_exception: EC2ThrottledException,
        ec2_unexpected_exception: EC2UnexpectedException,
        efs_mount_connectivity_exception: EFSMountConnectivityException,
        efs_mount_failure_exception: EFSMountFailureException,
        efs_mount_timeout_exception: EFSMountTimeoutException,
        efsio_exception: EFSIOException,
        eni_limit_reached_exception: ENILimitReachedException,
        eni_not_ready_exception: ENINotReadyException,
        function_versions_per_capacity_provider_limit_exceeded_exception: FunctionVersionsPerCapacityProviderLimitExceededException,
        invalid_code_signature_exception: InvalidCodeSignatureException,
        invalid_parameter_value_exception: InvalidParameterValueException,
        invalid_request_content_exception: InvalidRequestContentException,
        invalid_runtime_exception: InvalidRuntimeException,
        invalid_security_group_id_exception: InvalidSecurityGroupIDException,
        invalid_subnet_id_exception: InvalidSubnetIDException,
        invalid_zip_file_exception: InvalidZipFileException,
        kms_access_denied_exception: KMSAccessDeniedException,
        kms_disabled_exception: KMSDisabledException,
        kms_invalid_state_exception: KMSInvalidStateException,
        kms_not_found_exception: KMSNotFoundException,
        mode_not_supported_exception: ModeNotSupportedException,
        no_published_version_exception: NoPublishedVersionException,
        policy_length_exceeded_exception: PolicyLengthExceededException,
        precondition_failed_exception: PreconditionFailedException,
        provisioned_concurrency_config_not_found_exception: ProvisionedConcurrencyConfigNotFoundException,
        public_policy_exception: PublicPolicyException,
        recursive_invocation_exception: RecursiveInvocationException,
        request_too_large_exception: RequestTooLargeException,
        resource_conflict_exception: ResourceConflictException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_not_ready_exception: ResourceNotReadyException,
        s3_files_mount_connectivity_exception: S3FilesMountConnectivityException,
        s3_files_mount_failure_exception: S3FilesMountFailureException,
        s3_files_mount_timeout_exception: S3FilesMountTimeoutException,
        serialized_request_entity_too_large_exception: SerializedRequestEntityTooLargeException,
        service_exception: ServiceException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        snap_start_exception: SnapStartException,
        snap_start_not_ready_exception: SnapStartNotReadyException,
        snap_start_regeneration_failure_exception: SnapStartRegenerationFailureException,
        snap_start_timeout_exception: SnapStartTimeoutException,
        subnet_ip_address_limit_reached_exception: SubnetIPAddressLimitReachedException,
        too_many_requests_exception: TooManyRequestsException,
        unsupported_media_type_exception: UnsupportedMediaTypeException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .alias_limit_exceeded_exception => "AliasLimitExceededException",
                .callback_timeout_exception => "CallbackTimeoutException",
                .capacity_provider_limit_exceeded_exception => "CapacityProviderLimitExceededException",
                .code_artifact_user_deleted_exception => "CodeArtifactUserDeletedException",
                .code_artifact_user_failed_exception => "CodeArtifactUserFailedException",
                .code_artifact_user_pending_exception => "CodeArtifactUserPendingException",
                .code_signing_config_not_found_exception => "CodeSigningConfigNotFoundException",
                .code_storage_exceeded_exception => "CodeStorageExceededException",
                .code_verification_failed_exception => "CodeVerificationFailedException",
                .durable_execution_already_started_exception => "DurableExecutionAlreadyStartedException",
                .ec2_access_denied_exception => "EC2AccessDeniedException",
                .ec2_throttled_exception => "EC2ThrottledException",
                .ec2_unexpected_exception => "EC2UnexpectedException",
                .efs_mount_connectivity_exception => "EFSMountConnectivityException",
                .efs_mount_failure_exception => "EFSMountFailureException",
                .efs_mount_timeout_exception => "EFSMountTimeoutException",
                .efsio_exception => "EFSIOException",
                .eni_limit_reached_exception => "ENILimitReachedException",
                .eni_not_ready_exception => "ENINotReadyException",
                .function_versions_per_capacity_provider_limit_exceeded_exception => "FunctionVersionsPerCapacityProviderLimitExceededException",
                .invalid_code_signature_exception => "InvalidCodeSignatureException",
                .invalid_parameter_value_exception => "InvalidParameterValueException",
                .invalid_request_content_exception => "InvalidRequestContentException",
                .invalid_runtime_exception => "InvalidRuntimeException",
                .invalid_security_group_id_exception => "InvalidSecurityGroupIDException",
                .invalid_subnet_id_exception => "InvalidSubnetIDException",
                .invalid_zip_file_exception => "InvalidZipFileException",
                .kms_access_denied_exception => "KMSAccessDeniedException",
                .kms_disabled_exception => "KMSDisabledException",
                .kms_invalid_state_exception => "KMSInvalidStateException",
                .kms_not_found_exception => "KMSNotFoundException",
                .mode_not_supported_exception => "ModeNotSupportedException",
                .no_published_version_exception => "NoPublishedVersionException",
                .policy_length_exceeded_exception => "PolicyLengthExceededException",
                .precondition_failed_exception => "PreconditionFailedException",
                .provisioned_concurrency_config_not_found_exception => "ProvisionedConcurrencyConfigNotFoundException",
                .public_policy_exception => "PublicPolicyException",
                .recursive_invocation_exception => "RecursiveInvocationException",
                .request_too_large_exception => "RequestTooLargeException",
                .resource_conflict_exception => "ResourceConflictException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_not_ready_exception => "ResourceNotReadyException",
                .s3_files_mount_connectivity_exception => "S3FilesMountConnectivityException",
                .s3_files_mount_failure_exception => "S3FilesMountFailureException",
                .s3_files_mount_timeout_exception => "S3FilesMountTimeoutException",
                .serialized_request_entity_too_large_exception => "SerializedRequestEntityTooLargeException",
                .service_exception => "ServiceException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .snap_start_exception => "SnapStartException",
                .snap_start_not_ready_exception => "SnapStartNotReadyException",
                .snap_start_regeneration_failure_exception => "SnapStartRegenerationFailureException",
                .snap_start_timeout_exception => "SnapStartTimeoutException",
                .subnet_ip_address_limit_reached_exception => "SubnetIPAddressLimitReachedException",
                .too_many_requests_exception => "TooManyRequestsException",
                .unsupported_media_type_exception => "UnsupportedMediaTypeException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .alias_limit_exceeded_exception => |e| e.message,
                .callback_timeout_exception => |e| e.message,
                .capacity_provider_limit_exceeded_exception => |e| e.message,
                .code_artifact_user_deleted_exception => |e| e.message,
                .code_artifact_user_failed_exception => |e| e.message,
                .code_artifact_user_pending_exception => |e| e.message,
                .code_signing_config_not_found_exception => |e| e.message,
                .code_storage_exceeded_exception => |e| e.message,
                .code_verification_failed_exception => |e| e.message,
                .durable_execution_already_started_exception => |e| e.message,
                .ec2_access_denied_exception => |e| e.message,
                .ec2_throttled_exception => |e| e.message,
                .ec2_unexpected_exception => |e| e.message,
                .efs_mount_connectivity_exception => |e| e.message,
                .efs_mount_failure_exception => |e| e.message,
                .efs_mount_timeout_exception => |e| e.message,
                .efsio_exception => |e| e.message,
                .eni_limit_reached_exception => |e| e.message,
                .eni_not_ready_exception => |e| e.message,
                .function_versions_per_capacity_provider_limit_exceeded_exception => |e| e.message,
                .invalid_code_signature_exception => |e| e.message,
                .invalid_parameter_value_exception => |e| e.message,
                .invalid_request_content_exception => |e| e.message,
                .invalid_runtime_exception => |e| e.message,
                .invalid_security_group_id_exception => |e| e.message,
                .invalid_subnet_id_exception => |e| e.message,
                .invalid_zip_file_exception => |e| e.message,
                .kms_access_denied_exception => |e| e.message,
                .kms_disabled_exception => |e| e.message,
                .kms_invalid_state_exception => |e| e.message,
                .kms_not_found_exception => |e| e.message,
                .mode_not_supported_exception => |e| e.message,
                .no_published_version_exception => |e| e.message,
                .policy_length_exceeded_exception => |e| e.message,
                .precondition_failed_exception => |e| e.message,
                .provisioned_concurrency_config_not_found_exception => |e| e.message,
                .public_policy_exception => |e| e.message,
                .recursive_invocation_exception => |e| e.message,
                .request_too_large_exception => |e| e.message,
                .resource_conflict_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_not_ready_exception => |e| e.message,
                .s3_files_mount_connectivity_exception => |e| e.message,
                .s3_files_mount_failure_exception => |e| e.message,
                .s3_files_mount_timeout_exception => |e| e.message,
                .serialized_request_entity_too_large_exception => |e| e.message,
                .service_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .snap_start_exception => |e| e.message,
                .snap_start_not_ready_exception => |e| e.message,
                .snap_start_regeneration_failure_exception => |e| e.message,
                .snap_start_timeout_exception => |e| e.message,
                .subnet_ip_address_limit_reached_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .unsupported_media_type_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .alias_limit_exceeded_exception => 400,
                .callback_timeout_exception => 400,
                .capacity_provider_limit_exceeded_exception => 400,
                .code_artifact_user_deleted_exception => 409,
                .code_artifact_user_failed_exception => 409,
                .code_artifact_user_pending_exception => 409,
                .code_signing_config_not_found_exception => 404,
                .code_storage_exceeded_exception => 400,
                .code_verification_failed_exception => 400,
                .durable_execution_already_started_exception => 409,
                .ec2_access_denied_exception => 502,
                .ec2_throttled_exception => 502,
                .ec2_unexpected_exception => 502,
                .efs_mount_connectivity_exception => 408,
                .efs_mount_failure_exception => 403,
                .efs_mount_timeout_exception => 408,
                .efsio_exception => 410,
                .eni_limit_reached_exception => 502,
                .eni_not_ready_exception => 502,
                .function_versions_per_capacity_provider_limit_exceeded_exception => 400,
                .invalid_code_signature_exception => 400,
                .invalid_parameter_value_exception => 400,
                .invalid_request_content_exception => 400,
                .invalid_runtime_exception => 502,
                .invalid_security_group_id_exception => 502,
                .invalid_subnet_id_exception => 502,
                .invalid_zip_file_exception => 502,
                .kms_access_denied_exception => 502,
                .kms_disabled_exception => 502,
                .kms_invalid_state_exception => 502,
                .kms_not_found_exception => 502,
                .mode_not_supported_exception => 400,
                .no_published_version_exception => 400,
                .policy_length_exceeded_exception => 400,
                .precondition_failed_exception => 412,
                .provisioned_concurrency_config_not_found_exception => 404,
                .public_policy_exception => 400,
                .recursive_invocation_exception => 400,
                .request_too_large_exception => 413,
                .resource_conflict_exception => 409,
                .resource_in_use_exception => 400,
                .resource_not_found_exception => 404,
                .resource_not_ready_exception => 502,
                .s3_files_mount_connectivity_exception => 408,
                .s3_files_mount_failure_exception => 403,
                .s3_files_mount_timeout_exception => 408,
                .serialized_request_entity_too_large_exception => 413,
                .service_exception => 500,
                .service_quota_exceeded_exception => 402,
                .snap_start_exception => 400,
                .snap_start_not_ready_exception => 409,
                .snap_start_regeneration_failure_exception => 409,
                .snap_start_timeout_exception => 408,
                .subnet_ip_address_limit_reached_exception => 502,
                .too_many_requests_exception => 429,
                .unsupported_media_type_exception => 415,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .alias_limit_exceeded_exception => |e| e.request_id,
                .callback_timeout_exception => |e| e.request_id,
                .capacity_provider_limit_exceeded_exception => |e| e.request_id,
                .code_artifact_user_deleted_exception => |e| e.request_id,
                .code_artifact_user_failed_exception => |e| e.request_id,
                .code_artifact_user_pending_exception => |e| e.request_id,
                .code_signing_config_not_found_exception => |e| e.request_id,
                .code_storage_exceeded_exception => |e| e.request_id,
                .code_verification_failed_exception => |e| e.request_id,
                .durable_execution_already_started_exception => |e| e.request_id,
                .ec2_access_denied_exception => |e| e.request_id,
                .ec2_throttled_exception => |e| e.request_id,
                .ec2_unexpected_exception => |e| e.request_id,
                .efs_mount_connectivity_exception => |e| e.request_id,
                .efs_mount_failure_exception => |e| e.request_id,
                .efs_mount_timeout_exception => |e| e.request_id,
                .efsio_exception => |e| e.request_id,
                .eni_limit_reached_exception => |e| e.request_id,
                .eni_not_ready_exception => |e| e.request_id,
                .function_versions_per_capacity_provider_limit_exceeded_exception => |e| e.request_id,
                .invalid_code_signature_exception => |e| e.request_id,
                .invalid_parameter_value_exception => |e| e.request_id,
                .invalid_request_content_exception => |e| e.request_id,
                .invalid_runtime_exception => |e| e.request_id,
                .invalid_security_group_id_exception => |e| e.request_id,
                .invalid_subnet_id_exception => |e| e.request_id,
                .invalid_zip_file_exception => |e| e.request_id,
                .kms_access_denied_exception => |e| e.request_id,
                .kms_disabled_exception => |e| e.request_id,
                .kms_invalid_state_exception => |e| e.request_id,
                .kms_not_found_exception => |e| e.request_id,
                .mode_not_supported_exception => |e| e.request_id,
                .no_published_version_exception => |e| e.request_id,
                .policy_length_exceeded_exception => |e| e.request_id,
                .precondition_failed_exception => |e| e.request_id,
                .provisioned_concurrency_config_not_found_exception => |e| e.request_id,
                .public_policy_exception => |e| e.request_id,
                .recursive_invocation_exception => |e| e.request_id,
                .request_too_large_exception => |e| e.request_id,
                .resource_conflict_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_not_ready_exception => |e| e.request_id,
                .s3_files_mount_connectivity_exception => |e| e.request_id,
                .s3_files_mount_failure_exception => |e| e.request_id,
                .s3_files_mount_timeout_exception => |e| e.request_id,
                .serialized_request_entity_too_large_exception => |e| e.request_id,
                .service_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .snap_start_exception => |e| e.request_id,
                .snap_start_not_ready_exception => |e| e.request_id,
                .snap_start_regeneration_failure_exception => |e| e.request_id,
                .snap_start_timeout_exception => |e| e.request_id,
                .subnet_ip_address_limit_reached_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
                .unsupported_media_type_exception => |e| e.request_id,
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

pub const AliasLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CallbackTimeoutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CapacityProviderLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CodeArtifactUserDeletedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CodeArtifactUserFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CodeArtifactUserPendingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CodeSigningConfigNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CodeStorageExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CodeVerificationFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DurableExecutionAlreadyStartedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EC2AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EC2ThrottledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EC2UnexpectedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EFSMountConnectivityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EFSMountFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EFSMountTimeoutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EFSIOException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ENILimitReachedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ENINotReadyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FunctionVersionsPerCapacityProviderLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCodeSignatureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestContentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRuntimeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSecurityGroupIDException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSubnetIDException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidZipFileException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSAccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSInvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ModeNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoPublishedVersionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyLengthExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PreconditionFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ProvisionedConcurrencyConfigNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PublicPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RecursiveInvocationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RequestTooLargeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceConflictException = struct {
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

pub const S3FilesMountConnectivityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const S3FilesMountFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const S3FilesMountTimeoutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SerializedRequestEntityTooLargeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapStartException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapStartNotReadyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapStartRegenerationFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapStartTimeoutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubnetIPAddressLimitReachedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedMediaTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};

/// Parse a service diagnostic. The caller must call deinit on the result.
pub fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) std.mem.Allocator.Error!ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AliasLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .alias_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CallbackTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .callback_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CapacityProviderLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .capacity_provider_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeArtifactUserDeletedException")) {
        return .{ .arena = arena, .kind = .{ .code_artifact_user_deleted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeArtifactUserFailedException")) {
        return .{ .arena = arena, .kind = .{ .code_artifact_user_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeArtifactUserPendingException")) {
        return .{ .arena = arena, .kind = .{ .code_artifact_user_pending_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeSigningConfigNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .code_signing_config_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeStorageExceededException")) {
        return .{ .arena = arena, .kind = .{ .code_storage_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeVerificationFailedException")) {
        return .{ .arena = arena, .kind = .{ .code_verification_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DurableExecutionAlreadyStartedException")) {
        return .{ .arena = arena, .kind = .{ .durable_execution_already_started_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EC2AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .ec2_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EC2ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .ec2_throttled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EC2UnexpectedException")) {
        return .{ .arena = arena, .kind = .{ .ec2_unexpected_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountConnectivityException")) {
        return .{ .arena = arena, .kind = .{ .efs_mount_connectivity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountFailureException")) {
        return .{ .arena = arena, .kind = .{ .efs_mount_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .efs_mount_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EFSIOException")) {
        return .{ .arena = arena, .kind = .{ .efsio_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ENILimitReachedException")) {
        return .{ .arena = arena, .kind = .{ .eni_limit_reached_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ENINotReadyException")) {
        return .{ .arena = arena, .kind = .{ .eni_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FunctionVersionsPerCapacityProviderLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .function_versions_per_capacity_provider_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCodeSignatureException")) {
        return .{ .arena = arena, .kind = .{ .invalid_code_signature_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestContentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_content_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRuntimeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_runtime_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityGroupIDException")) {
        return .{ .arena = arena, .kind = .{ .invalid_security_group_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnetIDException")) {
        return .{ .arena = arena, .kind = .{ .invalid_subnet_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidZipFileException")) {
        return .{ .arena = arena, .kind = .{ .invalid_zip_file_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .kms_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledException")) {
        return .{ .arena = arena, .kind = .{ .kms_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .kms_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ModeNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .mode_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoPublishedVersionException")) {
        return .{ .arena = arena, .kind = .{ .no_published_version_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyLengthExceededException")) {
        return .{ .arena = arena, .kind = .{ .policy_length_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ProvisionedConcurrencyConfigNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .provisioned_concurrency_config_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PublicPolicyException")) {
        return .{ .arena = arena, .kind = .{ .public_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RecursiveInvocationException")) {
        return .{ .arena = arena, .kind = .{ .recursive_invocation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .request_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceConflictException")) {
        return .{ .arena = arena, .kind = .{ .resource_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3FilesMountConnectivityException")) {
        return .{ .arena = arena, .kind = .{ .s3_files_mount_connectivity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3FilesMountFailureException")) {
        return .{ .arena = arena, .kind = .{ .s3_files_mount_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3FilesMountTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .s3_files_mount_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SerializedRequestEntityTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .serialized_request_entity_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartException")) {
        return .{ .arena = arena, .kind = .{ .snap_start_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .snap_start_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartRegenerationFailureException")) {
        return .{ .arena = arena, .kind = .{ .snap_start_regeneration_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .snap_start_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetIPAddressLimitReachedException")) {
        return .{ .arena = arena, .kind = .{ .subnet_ip_address_limit_reached_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedMediaTypeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_media_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
