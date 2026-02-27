pub const ValidateStateMachineDefinitionSeverity = enum {
    @"error",
    warning,

    pub const json_field_names = .{
        .@"error" = "ERROR",
        .warning = "WARNING",
    };
};
