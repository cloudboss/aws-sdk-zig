pub const StepActionType = enum {
    manual,
    automated,

    pub const json_field_names = .{
        .manual = "MANUAL",
        .automated = "AUTOMATED",
    };
};
