pub const PropertyValidationExceptionReason = enum {
    invalid_format,
    unique_constraint_violated,
    referenced_resource_not_found,
    resource_name_already_exists,
    required_property_missing,
    not_supported,

    pub const json_field_names = .{
        .invalid_format = "INVALID_FORMAT",
        .unique_constraint_violated = "UNIQUE_CONSTRAINT_VIOLATED",
        .referenced_resource_not_found = "REFERENCED_RESOURCE_NOT_FOUND",
        .resource_name_already_exists = "RESOURCE_NAME_ALREADY_EXISTS",
        .required_property_missing = "REQUIRED_PROPERTY_MISSING",
        .not_supported = "NOT_SUPPORTED",
    };
};
