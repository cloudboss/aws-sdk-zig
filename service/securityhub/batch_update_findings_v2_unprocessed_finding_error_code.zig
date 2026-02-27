pub const BatchUpdateFindingsV2UnprocessedFindingErrorCode = enum {
    resource_not_found_exception,
    validation_exception,
    internal_server_exception,
    conflict_exception,

    pub const json_field_names = .{
        .resource_not_found_exception = "ResourceNotFoundException",
        .validation_exception = "ValidationException",
        .internal_server_exception = "InternalServerException",
        .conflict_exception = "ConflictException",
    };
};
