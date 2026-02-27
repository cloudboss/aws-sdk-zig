pub const AnalysisTemplateValidationStatus = enum {
    valid,
    invalid,
    unable_to_validate,

    pub const json_field_names = .{
        .valid = "VALID",
        .invalid = "INVALID",
        .unable_to_validate = "UNABLE_TO_VALIDATE",
    };
};
