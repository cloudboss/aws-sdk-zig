pub const VariantStatus = enum {
    creating,
    updating,
    deleting,
    activating_traffic,
    baking,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .activating_traffic = "ACTIVATING_TRAFFIC",
        .baking = "BAKING",
    };
};
