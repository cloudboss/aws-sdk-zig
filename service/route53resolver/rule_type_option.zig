pub const RuleTypeOption = enum {
    forward,
    system,
    recursive,
    delegate,

    pub const json_field_names = .{
        .forward = "Forward",
        .system = "System",
        .recursive = "Recursive",
        .delegate = "Delegate",
    };
};
