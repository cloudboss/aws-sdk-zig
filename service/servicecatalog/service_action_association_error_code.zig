pub const ServiceActionAssociationErrorCode = enum {
    duplicate_resource_exception,
    internal_failure,
    limit_exceeded_exception,
    resource_not_found_exception,
    throttling_exception,
    invalid_parameter_exception,

    pub const json_field_names = .{
        .duplicate_resource_exception = "DuplicateResourceException",
        .internal_failure = "InternalFailure",
        .limit_exceeded_exception = "LimitExceededException",
        .resource_not_found_exception = "ResourceNotFoundException",
        .throttling_exception = "ThrottlingException",
        .invalid_parameter_exception = "InvalidParameterException",
    };
};
