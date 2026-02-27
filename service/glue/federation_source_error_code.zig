pub const FederationSourceErrorCode = enum {
    access_denied_exception,
    entity_not_found_exception,
    invalid_credentials_exception,
    invalid_input_exception,
    invalid_response_exception,
    operation_timeout_exception,
    operation_not_supported_exception,
    internal_service_exception,
    partial_failure_exception,
    throttling_exception,

    pub const json_field_names = .{
        .access_denied_exception = "AccessDeniedException",
        .entity_not_found_exception = "EntityNotFoundException",
        .invalid_credentials_exception = "InvalidCredentialsException",
        .invalid_input_exception = "InvalidInputException",
        .invalid_response_exception = "InvalidResponseException",
        .operation_timeout_exception = "OperationTimeoutException",
        .operation_not_supported_exception = "OperationNotSupportedException",
        .internal_service_exception = "InternalServiceException",
        .partial_failure_exception = "PartialFailureException",
        .throttling_exception = "ThrottlingException",
    };
};
