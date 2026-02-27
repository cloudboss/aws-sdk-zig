pub const DeleteUniqueIdErrorType = enum {
    service_error,
    validation_error,

    pub const json_field_names = .{
        .service_error = "SERVICE_ERROR",
        .validation_error = "VALIDATION_ERROR",
    };
};
