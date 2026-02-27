pub const ValidatePolicyFindingType = enum {
    @"error",
    security_warning,
    suggestion,
    warning,

    pub const json_field_names = .{
        .@"error" = "ERROR",
        .security_warning = "SECURITY_WARNING",
        .suggestion = "SUGGESTION",
        .warning = "WARNING",
    };
};
