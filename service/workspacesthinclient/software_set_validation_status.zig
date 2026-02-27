pub const SoftwareSetValidationStatus = enum {
    validated,
    not_validated,

    pub const json_field_names = .{
        .validated = "VALIDATED",
        .not_validated = "NOT_VALIDATED",
    };
};
