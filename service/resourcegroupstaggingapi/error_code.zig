pub const ErrorCode = enum {
    internal_service_exception,
    invalid_parameter_exception,

    pub const json_field_names = .{
        .internal_service_exception = "INTERNAL_SERVICE_EXCEPTION",
        .invalid_parameter_exception = "INVALID_PARAMETER_EXCEPTION",
    };
};
