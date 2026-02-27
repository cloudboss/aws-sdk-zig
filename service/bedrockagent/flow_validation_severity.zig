pub const FlowValidationSeverity = enum {
    warning,
    @"error",

    pub const json_field_names = .{
        .warning = "WARNING",
        .@"error" = "ERROR",
    };
};
