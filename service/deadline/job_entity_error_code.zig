pub const JobEntityErrorCode = enum {
    access_denied_exception,
    internal_server_exception,
    validation_exception,
    resource_not_found_exception,
    max_payload_size_exceeded,
    conflict_exception,

    pub const json_field_names = .{
        .access_denied_exception = "AccessDeniedException",
        .internal_server_exception = "InternalServerException",
        .validation_exception = "ValidationException",
        .resource_not_found_exception = "ResourceNotFoundException",
        .max_payload_size_exceeded = "MaxPayloadSizeExceeded",
        .conflict_exception = "ConflictException",
    };
};
