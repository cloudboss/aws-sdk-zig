pub const AdditionalAnalyses = enum {
    allowed,
    required,
    not_allowed,

    pub const json_field_names = .{
        .allowed = "ALLOWED",
        .required = "REQUIRED",
        .not_allowed = "NOT_ALLOWED",
    };
};
