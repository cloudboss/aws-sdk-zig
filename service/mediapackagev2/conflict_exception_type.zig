pub const ConflictExceptionType = enum {
    resource_in_use,
    resource_already_exists,
    idempotent_parameter_mismatch,
    conflicting_operation,

    pub const json_field_names = .{
        .resource_in_use = "RESOURCE_IN_USE",
        .resource_already_exists = "RESOURCE_ALREADY_EXISTS",
        .idempotent_parameter_mismatch = "IDEMPOTENT_PARAMETER_MISMATCH",
        .conflicting_operation = "CONFLICTING_OPERATION",
    };
};
