pub const BlueprintStatus = enum {
    creating,
    active,
    updating,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .failed = "FAILED",
    };
};
