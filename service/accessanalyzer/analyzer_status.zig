pub const AnalyzerStatus = enum {
    active,
    creating,
    disabled,
    failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .creating = "CREATING",
        .disabled = "DISABLED",
        .failed = "FAILED",
    };
};
