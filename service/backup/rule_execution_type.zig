pub const RuleExecutionType = enum {
    continuous,
    snapshots,
    continuous_and_snapshots,

    pub const json_field_names = .{
        .continuous = "CONTINUOUS",
        .snapshots = "SNAPSHOTS",
        .continuous_and_snapshots = "CONTINUOUS_AND_SNAPSHOTS",
    };
};
