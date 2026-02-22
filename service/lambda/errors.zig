const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        callback_timeout_exception: CallbackTimeoutException,
        capacity_provider_limit_exceeded_exception: CapacityProviderLimitExceededException,
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
        no_published_version_exception: NoPublishedVersionException,
        policy_length_exceeded_exception: PolicyLengthExceededException,
        precondition_failed_exception: PreconditionFailedException,
        provisioned_concurrency_config_not_found_exception: ProvisionedConcurrencyConfigNotFoundException,
        recursive_invocation_exception: RecursiveInvocationException,
        request_too_large_exception: RequestTooLargeException,
        resource_conflict_exception: ResourceConflictException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_not_ready_exception: ResourceNotReadyException,
        serialized_request_entity_too_large_exception: SerializedRequestEntityTooLargeException,
        service_exception: ServiceException,
        snap_start_exception: SnapStartException,
        snap_start_not_ready_exception: SnapStartNotReadyException,
        snap_start_timeout_exception: SnapStartTimeoutException,
        subnet_ip_address_limit_reached_exception: SubnetIPAddressLimitReachedException,
        too_many_requests_exception: TooManyRequestsException,
        unsupported_media_type_exception: UnsupportedMediaTypeException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .callback_timeout_exception => "CallbackTimeoutException",
                .capacity_provider_limit_exceeded_exception => "CapacityProviderLimitExceededException",
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
                .no_published_version_exception => "NoPublishedVersionException",
                .policy_length_exceeded_exception => "PolicyLengthExceededException",
                .precondition_failed_exception => "PreconditionFailedException",
                .provisioned_concurrency_config_not_found_exception => "ProvisionedConcurrencyConfigNotFoundException",
                .recursive_invocation_exception => "RecursiveInvocationException",
                .request_too_large_exception => "RequestTooLargeException",
                .resource_conflict_exception => "ResourceConflictException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_not_ready_exception => "ResourceNotReadyException",
                .serialized_request_entity_too_large_exception => "SerializedRequestEntityTooLargeException",
                .service_exception => "ServiceException",
                .snap_start_exception => "SnapStartException",
                .snap_start_not_ready_exception => "SnapStartNotReadyException",
                .snap_start_timeout_exception => "SnapStartTimeoutException",
                .subnet_ip_address_limit_reached_exception => "SubnetIPAddressLimitReachedException",
                .too_many_requests_exception => "TooManyRequestsException",
                .unsupported_media_type_exception => "UnsupportedMediaTypeException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .callback_timeout_exception => |e| e.message,
                .capacity_provider_limit_exceeded_exception => |e| e.message,
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
                .no_published_version_exception => |e| e.message,
                .policy_length_exceeded_exception => |e| e.message,
                .precondition_failed_exception => |e| e.message,
                .provisioned_concurrency_config_not_found_exception => |e| e.message,
                .recursive_invocation_exception => |e| e.message,
                .request_too_large_exception => |e| e.message,
                .resource_conflict_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_not_ready_exception => |e| e.message,
                .serialized_request_entity_too_large_exception => |e| e.message,
                .service_exception => |e| e.message,
                .snap_start_exception => |e| e.message,
                .snap_start_not_ready_exception => |e| e.message,
                .snap_start_timeout_exception => |e| e.message,
                .subnet_ip_address_limit_reached_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .unsupported_media_type_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .callback_timeout_exception => 400,
                .capacity_provider_limit_exceeded_exception => 400,
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
                .no_published_version_exception => 400,
                .policy_length_exceeded_exception => 400,
                .precondition_failed_exception => 412,
                .provisioned_concurrency_config_not_found_exception => 404,
                .recursive_invocation_exception => 400,
                .request_too_large_exception => 413,
                .resource_conflict_exception => 409,
                .resource_in_use_exception => 400,
                .resource_not_found_exception => 404,
                .resource_not_ready_exception => 502,
                .serialized_request_entity_too_large_exception => 413,
                .service_exception => 500,
                .snap_start_exception => 400,
                .snap_start_not_ready_exception => 409,
                .snap_start_timeout_exception => 408,
                .subnet_ip_address_limit_reached_exception => 502,
                .too_many_requests_exception => 429,
                .unsupported_media_type_exception => 415,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .callback_timeout_exception => |e| e.request_id,
                .capacity_provider_limit_exceeded_exception => |e| e.request_id,
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
                .no_published_version_exception => |e| e.request_id,
                .policy_length_exceeded_exception => |e| e.request_id,
                .precondition_failed_exception => |e| e.request_id,
                .provisioned_concurrency_config_not_found_exception => |e| e.request_id,
                .recursive_invocation_exception => |e| e.request_id,
                .request_too_large_exception => |e| e.request_id,
                .resource_conflict_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_not_ready_exception => |e| e.request_id,
                .serialized_request_entity_too_large_exception => |e| e.request_id,
                .service_exception => |e| e.request_id,
                .snap_start_exception => |e| e.request_id,
                .snap_start_not_ready_exception => |e| e.request_id,
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

pub const CallbackTimeoutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CapacityProviderLimitExceededException = struct {
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

pub const SerializedRequestEntityTooLargeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceException = struct {
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
