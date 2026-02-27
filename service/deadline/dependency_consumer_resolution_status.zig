pub const DependencyConsumerResolutionStatus = enum {
    resolved,
    unresolved,

    pub const json_field_names = .{
        .resolved = "RESOLVED",
        .unresolved = "UNRESOLVED",
    };
};
