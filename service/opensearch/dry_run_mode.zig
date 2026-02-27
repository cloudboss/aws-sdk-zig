pub const DryRunMode = enum {
    basic,
    verbose,

    pub const json_field_names = .{
        .basic = "Basic",
        .verbose = "Verbose",
    };
};
