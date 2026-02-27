pub const OrchestrationType = enum {
    default,
    custom_orchestration,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .custom_orchestration = "CUSTOM_ORCHESTRATION",
    };
};
