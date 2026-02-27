pub const AccessPreviewStatusReasonCode = enum {
    internal_error,
    invalid_configuration,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .invalid_configuration = "INVALID_CONFIGURATION",
    };
};
